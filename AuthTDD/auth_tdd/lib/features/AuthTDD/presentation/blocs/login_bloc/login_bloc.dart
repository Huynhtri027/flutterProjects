import 'dart:async';
import 'package:auth_tdd/core/error/failures.dart';
import 'package:auth_tdd/core/usecases/usecase.dart';
import 'package:auth_tdd/features/AuthTDD/domain/entities/authtdd.dart';
import 'package:auth_tdd/features/AuthTDD/domain/usecases/get_firebase_auth.dart';
//import 'package:basic_app/repositories/firebase_auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import './login_barrel.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  //FirebaseAuthRepository _firebaseAuthRepository;

  final GetFirebaseAuth getFirebaseAuth;

  LoginBloc({
    @required GetFirebaseAuth firebaseAuthRepo,
  })  : assert(firebaseAuthRepo != null),
        getFirebaseAuth = firebaseAuthRepo, super(null);

  

  LoginState get initialState => LoginState.initial();

 

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
   if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    }
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    //try {
      final failureOrAuthenticated = await getFirebaseAuth(NoParams());
      yield* _eitherAuthenticatedOrErrorState(failureOrAuthenticated);
      //yield LoginState.success();
    //} catch (_) {
      //yield LoginState.failure();
    //}
  }

  Stream<LoginState> _eitherAuthenticatedOrErrorState(
    Either<Failures,User> failureOrAuthenticated,)async* {
    yield failureOrAuthenticated.fold(
      (failure) => LoginState.failure(),
      (user) => LoginState.success(),
    );
  }
  
}

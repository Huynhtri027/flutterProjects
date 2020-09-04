import 'dart:async';
import 'package:auth_tdd/core/usecases/usecase.dart';
import 'package:auth_tdd/features/AuthTDD/domain/usecases/get_firebase_auth.dart';
//import 'package:basic_app/repositories/firebase_auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import './login_barrel.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  //FirebaseAuthRepository _firebaseAuthRepository;

  final GetFirebaseAuth getFirebaseAuth;

  LoginBloc({
    @required GetFirebaseAuth firebaseAuthRepo,
  })  : assert(firebaseAuthRepo != null),
        getFirebaseAuth = firebaseAuthRepo, super(null);

  

  @override
  LoginState get initialState => LoginState.initial();

 

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
   if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    }
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      await getFirebaseAuth(NoParams());
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}

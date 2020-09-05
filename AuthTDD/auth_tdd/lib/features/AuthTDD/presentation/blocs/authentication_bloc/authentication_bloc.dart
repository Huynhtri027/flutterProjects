import 'dart:async';
import 'package:auth_tdd/features/AuthTDD/data/repositories/authtdd_repository_impl.dart';
import 'package:auth_tdd/features/AuthTDD/domain/usecases/get_firebase_auth.dart';
//import 'package:basic_app/repositories/firebase_auth_repository.dart';
import 'package:bloc/bloc.dart';
//import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import './authentication_barrel.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationBlocEvent, AuthenticationBlocState> {
  //final GetFirebaseAuth getFirebaseAuth;
  final AuthTDDRepositoryImpl authTDDRepositoryImpl;

  AuthenticationBloc({
    @required AuthTDDRepositoryImpl authTDDRepository,
  })  : assert(authTDDRepository != null),
        authTDDRepositoryImpl = authTDDRepository, super(null);

  // AuthenticationBloc({
  //   @required GetFirebaseAuth firebaseAuthRepo,
  // })  : assert(getFirebaseAuth != null),
  //       getFirebaseAuth = getFirebaseAuth, super(null);

  AuthenticationBlocState get initialState => AuthenticationBlocInitial();

  @override
  Stream<AuthenticationBlocState> mapEventToState(
    AuthenticationBlocEvent event,
  ) async* {
    if (event is AuthenticationStarted) {
      yield* _mapAuthenticationStartedToState();
    } else if (event is AuthenticationLoggedIn) {
      yield* _mapAuthenticationLoggedInToState();
    } else if (event is AuthenticationLoggedOut) {
      yield* _mapAuthenticationLoggedOutToState();
    }
  }

  Stream<AuthenticationBlocState> _mapAuthenticationStartedToState() async* {
    final isSignedIn = await authTDDRepositoryImpl.isSignedIn();
    if (isSignedIn) {
      final name = await authTDDRepositoryImpl.getUser();
      yield AuthenticationSuccess(name);
    } else {
      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationBlocState> _mapAuthenticationLoggedInToState() async* {
    yield AuthenticationSuccess(await authTDDRepositoryImpl.getUser());
  }

  Stream<AuthenticationBlocState> _mapAuthenticationLoggedOutToState() async* {
    yield AuthenticationFailure();
    authTDDRepositoryImpl.signOut();
  }
}

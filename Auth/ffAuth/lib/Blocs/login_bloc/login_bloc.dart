import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ffAuth/Blocs/login_bloc/login_event.dart';
import 'package:ffAuth/Blocs/login_bloc/login_state.dart';
import 'package:ffAuth/repositories/firebase_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  FirebaseAuthRepository _firebaseAuthRepository;
  String status;

  LoginBloc({
    @required FirebaseAuthRepository firebaseAuthRepository,
  })  : assert(firebaseAuthRepository != null),
        _firebaseAuthRepository = firebaseAuthRepository,
        super(null);

  LoginState get initialState => LoginState.initial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is LoginWithEmailPassword) {
      yield* _mapLoginWithEmailPasswordToState(
          event.name, event.email, event.password);
    } else if (event is SignInWithEmailPassword) {
      yield* _mapSignInWithEmailPasswordToState(event.email, event.password);
    } else if (event is ForgotPwdSubmit) {
      yield* _mapForgotPwdSubmitToState(event.email);
    } else if (event is LoginAnonymous) {
      yield* _mapLoginAnonymousToState();
    }
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      await _firebaseAuthRepository.signInWithGoogle();
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure(status);
    }
  }

  Stream<LoginState> _mapLoginWithEmailPasswordToState(
      String name, String email, String password) async* {
    try {
      print(email);
      status = await _firebaseAuthRepository.createWithEmailPassword(
          name, email, password);
      print(status);
      if (status == null) {
        yield LoginState.success();
      } else {
        yield LoginState.failure(status);
      }
    } catch (_) {
      yield LoginState.failure(status);
    }
  }

  Stream<LoginState> _mapSignInWithEmailPasswordToState(
      String email, String password) async* {
    try {
      print(email);
      status = await _firebaseAuthRepository.signInWithEmailPassword(
          email, password);
      print(status);
      if (status == null) {
        yield LoginState.success();
      } else {
        yield LoginState.failure(status);
      }
    } catch (_) {
      yield LoginState.failure(status);
    }
  }

  Stream<LoginState> _mapForgotPwdSubmitToState(String email) async* {
    try {
      print(email);
      status = await _firebaseAuthRepository.forgotPwdSubmit(email);
      print(status);
      if (status == null) {
        yield LoginState.success();
      } else {
        yield LoginState.failure(status);
      }
    } catch (_) {
      yield LoginState.failure(status);
    }
  }

  Stream<LoginState> _mapLoginAnonymousToState() async* {
    try {
      status = await _firebaseAuthRepository.signInAnonymously();
      print(status);
      if (status == null) {
        yield LoginState.success();
      } else {
        yield LoginState.failure(status);
      }
    } catch (_) {
      yield LoginState.failure(status);
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ffAuth/Blocs/login_bloc/login_event.dart';
import 'package:ffAuth/Blocs/login_bloc/login_state.dart';
import 'package:ffAuth/repositories/firebase_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      yield* _mapLoginWithEmailPassword(event.email,event.password);
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

  Stream<LoginState> _mapLoginWithEmailPassword(String email, String password) async*{
    
  try {
    print(email);
    status = await _firebaseAuthRepository.createWithEmailPassword(email, password);
    print(status);
    if(status == null) {
      yield LoginState.success();
    } else {
      yield LoginState.failure(status);     
    }
  } catch (_) {
    yield LoginState.failure(status);
  }
}
}



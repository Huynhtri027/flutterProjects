import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ffAuth/Blocs/login_bloc/login_event.dart';
import 'package:ffAuth/Blocs/login_bloc/login_state.dart';
import 'package:ffAuth/repositories/firebase_auth_repository.dart';
import 'package:meta/meta.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  FirebaseAuthRepository _firebaseAuthRepository;

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
    }
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      await _firebaseAuthRepository.signInWithGoogle();
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}

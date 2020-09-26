import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginWithGooglePressed extends LoginEvent {}

class LoginWithEmailPassword extends LoginEvent {
  final String email;
  final String password;

  LoginWithEmailPassword({@required this.email,@required this.password});
}


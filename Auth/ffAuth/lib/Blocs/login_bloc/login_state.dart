import 'package:meta/meta.dart';

@immutable
class LoginState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String exceptionMessage;
  

  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginState({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.exceptionMessage, 
  });

  factory LoginState.initial() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false, 
      exceptionMessage: null,
    );
  }

  factory LoginState.loading() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false, 
      exceptionMessage: null,
    );
  }

  factory LoginState.failure(String status) {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true, 
      exceptionMessage: status.toString(),
    );
  }

  factory LoginState.success() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false, 
      exceptionMessage: null,
    );
  }

  LoginState update({
    bool isEmailValid,
    bool isPasswordValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  LoginState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return LoginState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure, 
      exceptionMessage: null,
    );
  }

  @override
  String toString() {
    return '''LoginState {
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,      
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}

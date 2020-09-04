import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String email;

  AuthUser(this.email);

  @override
  List<Object> get props => [email];
  
}
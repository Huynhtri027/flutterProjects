import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthUser implements User {
  String email;

  AuthUser({this.email});

  @override
  List<Object> get props => [email];
  
}
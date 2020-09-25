import 'package:ffAuth/repositories/firebase_auth_repository.dart';
import 'package:ffAuth/screens/signin_screen.dart';
import 'package:ffAuth/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {

  final FirebaseAuthRepository _firebaseAuthRepository;

  MainScreen({Key key, @required FirebaseAuthRepository firebaseAuthRepository})
    : assert(firebaseAuthRepository != null),
      _firebaseAuthRepository = firebaseAuthRepository,
      super(key : key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                  child: Text('Sign Up'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  }),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                  child: Text('Sign In'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInScreen(firebaseAuthRepository: _firebaseAuthRepository)));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
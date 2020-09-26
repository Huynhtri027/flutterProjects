import 'package:ffAuth/Blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ffAuth/repositories/firebase_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseAuthRepository firebaseAuthRepository;
  final String displayName,email;

  const HomeScreen({Key key, this.displayName,this.email, this.firebaseAuthRepository})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationLoggedOut());
              },
              child: Icon(Icons.arrow_back))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              displayName?? 'No name',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text(
              email?? 'No email',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

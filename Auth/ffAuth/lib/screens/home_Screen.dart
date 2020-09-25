import 'package:ffAuth/Blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ffAuth/repositories/firebase_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseAuthRepository firebaseAuthRepository;
  final String displayName;

  const HomeScreen({Key key, this.displayName, this.firebaseAuthRepository})
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
        child: Text(
          displayName,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

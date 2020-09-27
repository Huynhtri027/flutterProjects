import 'package:ffAuth/Blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ffAuth/Blocs/login_bloc/login_bloc.dart';
import 'package:ffAuth/Blocs/login_bloc/login_event.dart';
import 'package:ffAuth/Blocs/login_bloc/login_state.dart';
import 'package:ffAuth/repositories/firebase_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignInScreen extends StatelessWidget {
  final FirebaseAuthRepository firebaseAuthRepository;

  const SignInScreen({Key key, this.firebaseAuthRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Login')),
      body: BlocProvider<LoginBloc>(
        create: (context) =>
            LoginBloc(firebaseAuthRepository: firebaseAuthRepository),
        child: SignIn(firebaseAuthRepository: firebaseAuthRepository),
      ),
    );
  }
}

class SignIn extends StatelessWidget {
  final FirebaseAuthRepository firebaseAuthRepository;

  const SignIn({Key key, this.firebaseAuthRepository}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.isFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Login Failure'), Icon(Icons.error)],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
          }
          if (state.isSubmitting) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Logging In...'),
                    ],
                  ),
                ),
              );
          }
          if (state.isSuccess) {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationLoggedIn());
                Navigator.pop(context);
          }
        },
        child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: Container(
                width: 300.0,
                height: 300.0,
                child: Column(
                  children: [
                    SignInButton(
                      Buttons.Google,
                      onPressed: () {
                        BlocProvider.of<LoginBloc>(context)
                            .add(LoginWithGooglePressed());
                      },
                    ),
                    SizedBox(height: 10.0),
                    RaisedButton(
                      child: Text('Sign in Anonymously'),
                      onPressed: () {
                        BlocProvider.of<LoginBloc>(context)
                            .add(LoginAnonymous());
                    })
                  ],
                ),
              ),
            )));
  }
}

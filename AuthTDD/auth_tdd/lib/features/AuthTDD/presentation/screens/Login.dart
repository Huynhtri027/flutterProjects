import 'package:auth_tdd/features/AuthTDD/presentation/blocs/authentication_bloc/authentication_barrel.dart';
import 'package:auth_tdd/features/AuthTDD/presentation/blocs/login_bloc/login_barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import '../../../../locator.dart';

class LoginScreen extends StatelessWidget {
  //final FirebaseAuthRepository _firebaseAuthRepository;

  // LoginScreen(
  //     {Key key, @required FirebaseAuthRepository firebaseAuthRepository})
  //     : assert(firebaseAuthRepository != null),
  //       _firebaseAuthRepository = firebaseAuthRepository,
  //       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocProvider<LoginBloc>(
        create: (_) => sl<LoginBloc>(),
            //LoginBloc(firebaseAuthRepository: firebaseAuthRepo),             No Need of this line
        //child: LoginPage(firebaseAuthRepository: _firebaseAuthRepository),   No Need of this line
        child: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  // LoginPage({Key key, @required FirebaseAuthRepository firebaseAuthRepository})
  //     : assert(firebaseAuthRepository != null),
  //       super(key: key);

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
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationLoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return RaisedButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            icon: Icon(FontAwesomeIcons.google, color: Colors.white),
            onPressed: () {
              BlocProvider.of<LoginBloc>(context).add(
                LoginWithGooglePressed(),
              );
            },
            label: Text('Sign in with Google',
                style: TextStyle(color: Colors.white)),
            color: Colors.redAccent,
          );
        },
      ),
    );
  }
}

import 'package:ffAuth/Blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ffAuth/Blocs/login_bloc/login_bloc.dart';
import 'package:ffAuth/Blocs/login_bloc/login_event.dart';
import 'package:ffAuth/Blocs/login_bloc/login_state.dart';
import 'package:ffAuth/repositories/firebase_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  final FirebaseAuthRepository firebaseAuthRepository;

  const SignUpScreen({Key key, this.firebaseAuthRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Login')),
      body: BlocProvider<LoginBloc>(
        create: (context) =>
            LoginBloc(firebaseAuthRepository: firebaseAuthRepository),
        child: SignUp(firebaseAuthRepository: firebaseAuthRepository),
      ),
    );
  }
}

class SignUp extends StatefulWidget {
  final FirebaseAuthRepository firebaseAuthRepository;

  SignUp({
    Key key,
    this.firebaseAuthRepository,
  }) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

final String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

class _SignUpState extends State<SignUp> {
  String email;
  String password;
  // FocusNode _emailFocus;
  // FocusNode _passwordFocus = FocusNode();
  void validation() async {
    print(email);
    final FormState _form = _formKey.currentState;
    if (!_form.validate() && email != null && password != null) {
      CircularProgressIndicator();
      BlocProvider.of<LoginBloc>(context)
          .add(LoginWithEmailPassword(email: email, password: password));
    } else {
      print("No");
    }
  }

  @override
  Widget build(BuildContext context) {
    RegExp regExp = new RegExp(p);
    //FocusNode _focusNode;

    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          // FirebaseException e;
          // final String message = e.message.toString();
          if (state.isFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(state.exceptionMessage.toString())),
                      Icon(Icons.error)
                    ],
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
            Navigator.pop(context);
          }
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text('Credential Auth Page'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Container(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 50.0,
                    ),
                    TextFormField(
                      autofocus: true,
                      //focusNode: _emailFocus,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == "") {
                          return "Please provide Email";
                        } else if (!regExp.hasMatch(value)) {
                          return "Email format not valid";
                        }
                        return "";
                      },
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });

                        //_focusNode.unfocus();

                        //_emailFocus.unfocus();
                        //FocusScope.of(context).requestFocus(_passwordFocus);
                      },
                      style: TextStyle(fontSize: 22.0),
                      decoration: InputDecoration(
                          hintText: 'Type Email',
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          contentPadding: EdgeInsets.all(5.0),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    TextFormField(
                        //focusNode: _passwordFocus,
                        validator: (value) {
                          if (value == "") {
                            return "Please provide Password";
                          } else if (value.length < 6) {
                            return "Password is too short";
                          }
                          return "";
                        },
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });

                          //   FocusScope.of(context).addListener(() {
                          //   validation();
                          // });
                        },
                        style: TextStyle(fontSize: 22.0),
                        decoration: InputDecoration(
                            hintText: 'Type Password',
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            contentPadding: EdgeInsets.all(5.0),
                            border: OutlineInputBorder())),
                    SizedBox(
                      height: 40.0,
                    ),
                    RaisedButton(
                      onPressed: () {
                        validation();
                      },
                      child: Text('Create Account'),
                      //color: Colors.black,
                    )
                  ],
                )),
              ),
            ),
          ),
        ));
  }
}

import 'package:ffAuth/Blocs/login_bloc/login_bloc.dart';
import 'package:ffAuth/Blocs/login_bloc/login_event.dart';
import 'package:ffAuth/Blocs/login_bloc/login_state.dart';
import 'package:ffAuth/repositories/firebase_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPwdScreen extends StatelessWidget {
  final FirebaseAuthRepository firebaseAuthRepository;

  const ForgotPwdScreen({Key key, this.firebaseAuthRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Login')),
      body: BlocProvider<LoginBloc>(
        create: (context) =>
            LoginBloc(firebaseAuthRepository: firebaseAuthRepository),
        child: ForgotPwd(firebaseAuthRepository: firebaseAuthRepository),
      ),
    );
  }
}

class ForgotPwd extends StatefulWidget {
  final FirebaseAuthRepository firebaseAuthRepository;

  const ForgotPwd({Key key, this.firebaseAuthRepository}) : super(key: key);

  @override
  _ForgotPwdState createState() => _ForgotPwdState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

String email;

class _ForgotPwdState extends State<ForgotPwd> {

  void validation() async {
      print(email);
      final FormState _form = _formKey.currentState;
      if (!_form.validate() && email != null) {
        //return "Yes";
        //CircularProgressIndicator();
        BlocProvider.of<LoginBloc>(context).add(ForgotPwdSubmit(email: email));
      } else {
        print("No");
        //return null;
      }
    }

  @override
  Widget build(BuildContext context) {
    RegExp regExp = new RegExp(p);

    

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
                      Text('Processing In...'),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
          }
          
          if (state.isSuccess) {
            // showDialog(
            //     context: context,
            //     //builder: ,
            //     child: Dialog(
            //         child: Column(
            //       children: [
            //         Text('Please check your email'),
            //         Text('A password reset link has been sent to $email'),
            //       ],
            //     )));
                Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text('A password reset link has been sent to $email')),
                    ],
                  ),
                ),
              );

            //Navigator.pop(context);
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
                      height: 20.0,
                    ),
                    TextFormField(
                      //autofocus: true,
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
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            validation();
                            // if (validation() != null) {
                            //   BlocProvider.of<LoginBloc>(context)
                            //       .add(ForgotPwdSubmit(email: email));
                            // }
                          },
                          child: Text('Submit'),
                          //color: Colors.black,
                        ),
                      ],
                    )
                  ],
                )),
              ),
            ),
          ),
        ));
  }
}

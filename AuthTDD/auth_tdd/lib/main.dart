import 'package:auth_tdd/features/AuthTDD/presentation/screens/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/AuthTDD/presentation/blocs/authentication_bloc/authentication_barrel.dart';
import 'features/AuthTDD/presentation/screens/Home.dart';
import 'locator.dart' as di;
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp();
  runApp(
    BlocProvider(
      create: (_) => sl<AuthenticationBloc>()..add(AuthenticationStarted()),
      // create: (context) => AuthenticationBloc(firebaseAuthRepo: null  No Need of this line
      // )..add(AuthenticationStarted()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AuthTDD',
      debugShowCheckedModeBanner: false,
      home:BlocBuilder<AuthenticationBloc, AuthenticationBlocState>(
        builder: (context, state) {
          if(state is AuthenticationSuccess){
            return HomePage(name : state.displayName,);
          }
          if(state is AuthenticationFailure){
            return LoginScreen();
          }
          return LoginScreen();
        },
      ),
    );
  }
}

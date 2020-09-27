import 'package:ffAuth/Blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ffAuth/repositories/firebase_auth_repository.dart';
import 'package:ffAuth/screens/home_Screen.dart';
import 'package:ffAuth/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final FirebaseAuthRepository firebaseAuthRepository =
      FirebaseAuthRepository();
  runApp(BlocProvider(
      create: (context) =>
          AuthenticationBloc(firebaseAuthRepository: firebaseAuthRepository)
            ..add(AuthenticationStarted()),
      child: MyApp(firebaseAuthRepository: firebaseAuthRepository)));
}

class MyApp extends StatelessWidget {
  final FirebaseAuthRepository _firebaseAuthRepository;

  MyApp({Key key, @required FirebaseAuthRepository firebaseAuthRepository})
      : assert(firebaseAuthRepository != null),
        _firebaseAuthRepository = firebaseAuthRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StreamBuilder<String>(
            stream: _firebaseAuthRepository.onAuthStateChanged,
            builder: (context, snapshot) {
              return BlocBuilder<AuthenticationBloc, AuthenticationBlocState>(
                builder: (context, state) {
                  if (state is AuthenticationBlocInitial) {
                    return CircularProgressIndicator();
                  } else if (state is AuthenticationSuccess) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      return HomeScreen(
                          firebaseAuthRepository: _firebaseAuthRepository,
                          displayName: state.displayName,
                          email: state.email);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => HomeScreen(
                      //             firebaseAuthRepository: _firebaseAuthRepository,
                      //             displayName: state.displayName)));
                    }
                  } else if (state is AuthenticationFailure) {
                    // return Dialog(
                    //   child: Text('Authentication failure'),
                    //   shape: RoundedRectangleBorder(),
                    // );
                    return MainScreen(
                        firebaseAuthRepository: _firebaseAuthRepository);
                  }
                  return CircularProgressIndicator();
                },
              );
            }));
  }
}

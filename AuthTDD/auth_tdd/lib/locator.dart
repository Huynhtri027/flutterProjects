import 'package:auth_tdd/features/AuthTDD/data/repositories/authtdd_repository_impl.dart';
import 'package:auth_tdd/features/AuthTDD/domain/repositories/authtdd_repository.dart';
import 'package:auth_tdd/features/AuthTDD/domain/usecases/get_firebase_auth.dart';
import 'package:auth_tdd/features/AuthTDD/presentation/blocs/authentication_bloc/authentication_barrel.dart';
import 'package:auth_tdd/features/AuthTDD/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //Bloc
  sl.registerFactory(
    () => LoginBloc(firebaseAuthRepo: sl()),
  );

  sl.registerFactory(
    () => AuthenticationBloc(authTDDRepository: sl()),
  );

  //Use cases
  sl.registerLazySingleton(() => GetFirebaseAuth(sl()));
  sl.registerLazySingleton(
      () => AuthTDDRepositoryImpl());

  //Repository
  sl.registerLazySingleton<AuthTDDRepository>(() => AuthTDDRepositoryImpl(
      ));

}

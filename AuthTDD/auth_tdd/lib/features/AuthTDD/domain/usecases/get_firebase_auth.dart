import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/authtdd_repository.dart';

class GetFirebaseAuth implements UseCase<User,NoParams>{
  final AuthTDDRepository authRepository;

  GetFirebaseAuth(this.authRepository);

  Future<Either<Failures,User>> call(NoParams params) async{
    return await authRepository.getFirebaseAuth();

  }
}


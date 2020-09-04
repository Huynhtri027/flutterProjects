import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/authtdd.dart';
import '../repositories/authtdd_repository.dart';

class GetFirebaseAuth implements UseCase<AuthUser,NoParams>{
  final AuthTDDRepository authRepository;

  GetFirebaseAuth(this.authRepository);

  Future<Either<Failures,AuthUser>> call(NoParams params) async{
    return await authRepository.getFirebaseAuth();
  }
}


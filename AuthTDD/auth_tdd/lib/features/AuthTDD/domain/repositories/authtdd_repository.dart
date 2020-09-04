import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/authtdd.dart';

abstract class AuthTDDRepository {
  Future<Either<Failures,AuthUser>> getFirebaseAuth();
}
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/failures.dart';

abstract class AuthTDDRepository {
  Future<Either<Failures,User>> getFirebaseAuth();
}
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
  
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class UseCaseStream<Type, Params> {
  Stream<Type> call(Params params);
}

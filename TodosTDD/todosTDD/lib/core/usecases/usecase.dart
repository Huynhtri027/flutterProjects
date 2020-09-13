import 'package:equatable/equatable.dart';

abstract class BaseUseCase<Result, Params> {
  Stream<Result> call(Params params);
  
}

class UseCaseResult {
  final Exception exception;
  final bool result;

  UseCaseResult(this.exception, this.result);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class UseCaseStream<Result, Params> {
  Stream<Result> call(Params params);
}

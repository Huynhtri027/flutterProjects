abstract class BaseUseCase<Result, Params> {
  Future<Result> call(Params params);
}

class UseCaseResult {
  final Exception exception;
  final bool result;

  UseCaseResult(this.exception, this.result);
}

abstract class UseCaseStream<Result, Params> {
  Stream<Result> call(Params params);
}

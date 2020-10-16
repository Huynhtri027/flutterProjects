import 'package:equatable/equatable.dart';

class Failure extends Equatable {

  final String message;

  Failure(this.message);

  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  CacheFailure(String message) : super(message);
}

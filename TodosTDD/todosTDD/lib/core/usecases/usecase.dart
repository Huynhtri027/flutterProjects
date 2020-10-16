import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:todosTDD/features/todosTDD/data/models/todos/todo.dart';

abstract class BaseUseCase<Result, Params> {
  Future<Result> call(Params params);
  
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

class TodosParams extends Equatable {    //Here we can provide ProductDetailsParams here
  final TodoModel todo;

  TodosParams({@required this.todo});

  @override
  List<Object> get props => [todo];
}

abstract class UseCaseStream<Result, Params> {
  Stream<Result> call(Params params);
}

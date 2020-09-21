import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:todosTDD/core/usecases/usecase.dart';
import 'package:todosTDD/features/todosTDD/data/models/todos/todo.dart';

abstract class AddTodoUsecase implements BaseUseCase<TodosResult,TodosParams> {}

class TodosUseCaseImpl implements AddTodoUsecase {
  @override
  Future<TodosResult> call(TodosParams params) {
    //odosRepositoryImpl todosRepositoryImpl = sl();
    //odosRepositoryImpl.addNewTodo(params.todo);
  }

}


class TodosParams extends Equatable {    //Here we can provide ProductDetailsParams here
  final TodoModel todo;

  TodosParams({@required this.todo});

  @override
  List<Object> get props => [todo];
}

class TodosResult extends UseCaseResult {
  final List<TodoModel> todosModel;

  TodosResult({this.todosModel}) : super(null, false);

  @override
  // TODO: implement exception
  Exception get exception => throw UnimplementedError();

  @override
  // TODO: implement result
  bool get result => throw UnimplementedError();
}

// //class TodosNoParams {}
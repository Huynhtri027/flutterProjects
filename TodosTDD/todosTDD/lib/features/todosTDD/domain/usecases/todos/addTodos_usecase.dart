import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../../../locator.dart';
import '../../../data/models/todos/todo.dart';
import '../../repositories/todos/todos_repository.dart';

abstract class AddTodoUsecase implements BaseUseCase<TodosResult, TodosParams> {
}

class AddTodoUsecaseImpl implements AddTodoUsecase {
  @override
  Future<TodosResult> call(TodosParams params) async {
    TodosRepository todosRepository = sl();
    todosRepository.addNewTodo(params.todo);
    return TodosResult(result: true);
  }
}

class TodosParams extends Equatable {
  final TodoModel todo;

  TodosParams({@required this.todo});

  @override
  List<Object> get props => [todo];
}

class TodosResult extends UseCaseResult {
  final List<TodoModel> todosModel;

  TodosResult({this.todosModel, bool result}) : super(null, false);

  @override
  // TODO: implement exception
  Exception get exception => throw UnimplementedError();

  @override
  // TODO: implement result
  bool get result => throw UnimplementedError();
}

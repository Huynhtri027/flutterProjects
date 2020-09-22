import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../../../locator.dart';
import '../../../data/models/todos/todo.dart';
import '../../repositories/todos/todos_repository.dart';

abstract class UpdateTodoUsecase
    implements BaseUseCase<TodosResult, TodosUParams> {}

class UpdateTodoUsecaseImpl implements UpdateTodoUsecase {
  @override
  Future<TodosResult> call(TodosUParams params) async {
    TodosRepository todosRepository = sl();
    todosRepository.updateTodo(params.todo);
    return TodosResult(result: true);
  }
}

class TodosUParams extends Equatable {
  //Here we can provide ProductDetailsParams here
  final TodoModel todo;

  TodosUParams({@required this.todo});

  @override
  List<Object> get props => [todo];
}

class TodosResult extends UseCaseResult {
  final List<TodoModel> todosModel;

  TodosResult({this.todosModel, bool result}) : super(null, false);
}

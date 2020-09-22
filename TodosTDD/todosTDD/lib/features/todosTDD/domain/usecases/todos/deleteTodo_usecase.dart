import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../../../locator.dart';
import '../../../data/models/todos/todo.dart';
import '../../repositories/todos/todos_repository.dart';

abstract class DeleteTodoUsecase
    implements BaseUseCase<TodosResult, TodosDParams> {}

class DeleteUsecaseImpl implements DeleteTodoUsecase {
  @override
  Future<TodosResult> call(TodosDParams params) async {
    TodosRepository todosRepository = sl();
    todosRepository.deleteTodo(params.todo);
    return TodosResult(result: true);
  }
}

class TodosDParams extends Equatable {
  final TodoModel todo;

  TodosDParams({@required this.todo});

  @override
  List<Object> get props => [todo];
}

class TodosResult extends UseCaseResult {
  final List<TodoModel> todosModel;

  TodosResult({this.todosModel, bool result}) : super(null, false);
}

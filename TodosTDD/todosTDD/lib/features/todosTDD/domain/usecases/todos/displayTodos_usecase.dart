import 'package:flutter/material.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../../../locator.dart';
import '../../../data/models/todos/todo.dart';
import '../../repositories/todos/todos_repository.dart';

abstract class DisplayTodosUsecase
    implements BaseUseCase<TodosResult, TodosNoParams> {}

class DisplayTodosUsecaseImpl implements DisplayTodosUsecase {
  @override
  Future<TodosResult> call(TodosNoParams noParams) async {
    TodosRepository todosRepository = sl();
    //List<TodoModel> todosGot = await todosRepository.todos(); //Need to provide sl() via Repo not via RepoImpl??
    return TodosResult(
      todos: await todosRepository.todos(),
    );
  }
}

class TodosResult extends UseCaseResult {
  final List<TodoModel> todos;

  TodosResult({@required this.todos}) : super(null, false);
}

class TodosNoParams {}

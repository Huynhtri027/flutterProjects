import 'package:flutter/material.dart';
import 'package:todosTDD/core/usecases/usecase.dart';
import 'package:todosTDD/features/todosTDD/data/models/todos/todo.dart';
import 'package:todosTDD/features/todosTDD/domain/repositories/todos/todos_repository.dart';
import 'package:todosTDD/locator.dart';

abstract class DisplayTodosUsecase implements BaseUseCase<TodosResult, TodosNoParams> {}

class DisplayTodosUsecaseImpl implements DisplayTodosUsecase {
  @override
  Future<TodosResult> call(TodosNoParams noParams) async {
    TodosRepository todosRepository = sl();
    //List<TodoModel> todosGot = await todosRepository.todos(); //Need to provide sl() not via RepoImpl??
    return TodosResult(
      todos: await todosRepository.todos(),
    );
  }

}


class TodosResult extends UseCaseResult {
  final List<TodoModel> todos;

  TodosResult({@required this.todos}) : super(null, false);

  @override
  // TODO: implement exception
  Exception get exception => throw UnimplementedError();

  @override
  // TODO: implement result
  bool get result => throw UnimplementedError();
}

class TodosNoParams {}
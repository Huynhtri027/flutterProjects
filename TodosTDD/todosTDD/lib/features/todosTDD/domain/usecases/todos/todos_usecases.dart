import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:todosTDD/core/usecases/usecase.dart';
import 'package:todosTDD/features/todosTDD/data/models/todos/todo.dart';
import 'package:todosTDD/features/todosTDD/domain/entities/todos/todo_entity.dart';
import 'package:todosTDD/features/todosTDD/domain/repositories/todos/todos_repository.dart';

import '../../../../../locator.dart';

abstract class TodosUsecase implements BaseUseCase<TodosResult, NoParams> {}
//Usecases and implementaion class contains same methods called up. And in Datasource we are writing the logic.
//Here we have the impls class for each usecases.
//In other project , we are having the use case with Rersult and params like this but
//its having impl of usecases but in same file and then its using directly the repo function or impl fucntions.

class AddNewTodoUC {
  final TodosRepository todosRepository;

  AddNewTodoUC(this.todosRepository);

  Future<void> call(TodosParams params) async {
    return await todosRepository.addNewTodo(params.todo);
  }
}

class DisplayTodoUC {
  TodosRepository todosRepository = sl();

  DisplayTodoUC(this.todosRepository);

  Stream<List<TodoEntity>> call(NoParams todosNoParams) {
    return todosRepository.todos();
  }
}

// class DisplayTodoUC extends TodosResult{  //Used in returning named params into Bloc callback
//   odosRepository todosRepository = sl();

//   DisplayTodoUC(this.todosRepository);

//   odosResult call(NoParams todosNoParams) {

//     return TodosResult(
//       odos: todosRepository.todos(),
//       );
//     //return todosRepository.todos();
//   }

class DeleteTodoUC {
  final TodosRepository todosRepository;

  DeleteTodoUC(this.todosRepository);

  Future<void> call(TodosParams params) {
    return todosRepository.deleteTodo(params.todo);
  }
}

class UpdateTodoUC {
  final TodosRepository todosRepository;

  UpdateTodoUC(this.todosRepository);

  Future<void> call(TodosParams params) {
    return todosRepository.updateTodo(params.todo);
  }
}

class TodosResult extends UseCaseResult {
  final Stream<List<TodoEntity>> todos;

  TodosResult({this.todos}) : super(null, false);

  @override
  // TODO: implement exception
  Exception get exception => throw UnimplementedError();

  @override
  // TODO: implement result
  bool get result => throw UnimplementedError();
}

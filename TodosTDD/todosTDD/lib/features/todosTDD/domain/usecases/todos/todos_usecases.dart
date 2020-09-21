import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:todosTDD/core/usecases/usecase.dart';
import 'package:todosTDD/features/todosTDD/data/models/todos/todo.dart';
import 'package:todosTDD/features/todosTDD/domain/repositories/todos/todos_repository.dart';

import '../../../../../locator.dart';

abstract class TodosUsecase implements BaseUseCase<TodosResult,NoParams> {}
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

class DisplayTodoUC implements TodosUsecase{ 

  TodosRepository todosRepository = sl();

  DisplayTodoUC(this.todosRepository);

  @override
  Future<TodosResult> call(NoParams params) async{
      return TodosResult(
      todosModel: await todosRepository.todos(),
      );

   //And in case of List<TodoModel> we can pass ProductDetailsResults and can be defined below

  // @override
  // Stream<TodosResult> call(NoParams params) {
  //   return todosRepository.todos();
  // }
  }

}

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

class TodosNoParams {}
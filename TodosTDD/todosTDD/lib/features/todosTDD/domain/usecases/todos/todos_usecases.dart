import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:todosTDD/core/usecases/usecase.dart';
import 'package:todosTDD/features/todosTDD/data/models/todos/todo.dart';
import 'package:todosTDD/features/todosTDD/domain/repositories/todos/todos_repository.dart';

class AddNewTodoUC implements UseCase<void, Params> {
  final TodosRepository todosRepository;

  AddNewTodoUC(this.todosRepository);

  @override
  Future<void> call(Params params) async {
    return await todosRepository.addNewTodo(params.todo);
  }
}

class DisplayTodoUC extends UseCaseStream<List<TodoModel>, NoParams> {
  final TodosRepository todosRepository;

  DisplayTodoUC(this.todosRepository);

  @override
  Stream<List<TodoModel>> call(NoParams params) {
    return todosRepository.todos();
  }
}

class DeleteTodoUC extends UseCase<void, Params> {
  final TodosRepository todosRepository;

  DeleteTodoUC(this.todosRepository);

  @override
  Future<void> call(Params params) {
    return todosRepository.deleteTodo(params.todo);
  }
}

class UpdateTodoUC extends UseCase<void, Params> {
  final TodosRepository todosRepository;

  UpdateTodoUC(this.todosRepository);

  @override
  Future<void> call(Params params) {
    return todosRepository.updateTodo(params.todo);
  }
}

class Params extends Equatable {
  final TodoModel todo;

  Params({@required this.todo});

  @override
  List<Object> get props => [todo];
}

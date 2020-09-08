import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:todosTDD/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:todosTDD/core/usecases/usecase.dart';
import 'package:todosTDD/features/todosTDD/data/models/todos/todo.dart';
import 'package:todosTDD/features/todosTDD/domain/entities/todos/todo_entity.dart';
import 'package:todosTDD/features/todosTDD/domain/repositories/todos/todos_repository.dart';

class AddNewTodo implements UseCase<void, Params> {
  final TodosRepository todosRepository;

  AddNewTodo(this.todosRepository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await todosRepository.addNewTodo(params.todo);
  }
}

class Params extends Equatable {
  final TodoModel todo;

  Params({@required this.todo});

  @override
  List<Object> get props => [todo];
}

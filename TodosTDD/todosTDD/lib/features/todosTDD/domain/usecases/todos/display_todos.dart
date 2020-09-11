import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:todosTDD/core/error/failures.dart';
import 'package:todosTDD/core/usecases/usecase.dart';
import 'package:todosTDD/features/todosTDD/data/models/todos/todo.dart';
import 'package:todosTDD/features/todosTDD/domain/entities/todos/todo_entity.dart';
import 'package:todosTDD/features/todosTDD/domain/repositories/todos/todos_repository.dart';

class DisplayTodo extends UseCaseStream<List<TodoModel>, NoParams> {
  final TodosRepository todosRepository;

  DisplayTodo(this.todosRepository);

  @override
  Future<Either<Failure, List<TodoModel>>> call(NoParams params) async{
    return todosRepository.todos();
  }
}

class Params extends Equatable {
  final TodoModel todo;

  Params({@required this.todo});

  @override
  List<Object> get props => [todo];
}

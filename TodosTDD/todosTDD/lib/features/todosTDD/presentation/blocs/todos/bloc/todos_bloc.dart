import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:todosTDD/core/error/failures.dart';
import 'package:todosTDD/features/todosTDD/data/models/todos/todo.dart';
import 'package:todosTDD/features/todosTDD/domain/repositories/todos/todos_repository.dart';
import 'package:todosTDD/features/todosTDD/presentation/blocs/todos/bloc/todo_barrel.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRepository _todosRepository;
  StreamSubscription _todosSubscription;

  TodosBloc({
    @required TodosRepository todosRepository
  }): assert(todosRepository!=null),
      _todosRepository = todosRepository, super(TodosLoading());

  /*TodosState get initialState => TodosLoading();*/

  @override
  Stream<TodosState> mapEventToState(
    TodosEvent event,
  ) async* {
    if (event is LoadTodos) {
      yield* _mapLoadTodosToState();
    } else if (event is TodosUpdated) {
      yield* _mapTodosUpdateToState(event);
    }
  }

  Stream<TodosState> _mapLoadTodosToState() async* {
    try {
      _todosSubscription?.cancel();
      //Stream<Either<Failure, Stream<List<TodoModel>>>> todos = _todosRepository.todos().asStream();
      _todosRepository.todos().fold(
        (failure) => TodosNotLoaded(), 
        (todos) => add(TodosUpdated(todos)));
        //print(todos);
    } catch (e) {
      print(e);
    }
  }

  Stream<TodosState> _mapTodosUpdateToState(TodosUpdated event) async* {
    yield TodosLoaded(event.todos);
  }

  @override
  Future<void> close() {
    _todosSubscription?.cancel();
    return super.close();
  }
}

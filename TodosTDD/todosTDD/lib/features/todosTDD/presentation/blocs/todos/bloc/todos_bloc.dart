import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:todosTDD/core/error/failures.dart';
import 'package:todosTDD/core/usecases/usecase.dart';
import 'package:todosTDD/features/todosTDD/data/models/todos/todo.dart';
import 'package:todosTDD/features/todosTDD/domain/repositories/todos/todos_repository.dart';
import 'package:todosTDD/features/todosTDD/domain/usecases/todos/display_todos.dart';
import 'package:todosTDD/features/todosTDD/presentation/blocs/blocs.dart';
import 'package:todosTDD/features/todosTDD/presentation/blocs/todos/bloc/todo_barrel.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
//  final TodosRepository _todosRepository;   
  StreamSubscription _todosSubscription; //Only UseCases we are instatiating here.
  DisplayTodo _displayTodo;

  TodosBloc({
    //@required TodosRepository todosRepository,
    @required DisplayTodo displayTodo,
  }): //assert(todosRepository!=null),
      assert(displayTodo!=null),
      //_todosRepository = todosRepository,
      _displayTodo = displayTodo,
      super(TodosLoading());

  /*TodosState get initialState => TodosLoading();*/

  @override
  Stream<TodosState> mapEventToState(
    TodosEvent event,
  ) async* {
    if (event is LoadTodos) {
      yield TodosLoading();
      final failureOrTodos = await _displayTodo(NoParams());    //This is where we include UseCase.
      yield* _mapLoadTodosToState(failureOrTodos);
    } else if (event is TodosUpdated) {
      yield* _mapTodosUpdateToState(event);
    }
  }

  Stream<TodosState> _mapLoadTodosToState(Either<Failure,Stream<List<TodoModel>>> failureOrTodos) async* {
    _todosSubscription?.cancel();
    //final failurOrTodos = _displayTodo.call(NoParams());

    // _todosSubscription =
    //     failureOrTodos.listen((todos) => add(TodosUpdated(todos: Right(todos))));
    failureOrTodos.fold(
      (failure) => TodosNotLoaded(),
      (todos) => _todosSubscription = todos.listen((todos) => add(TodosUpdated(todos: todos))));
  }

  // Stream<TodosState> _mapLoadTodosToState(
  //   Either<Failure,List<TodoModel>> failureOrTodos) async* {
  //   try {
  //     _todosSubscription?.cancel();
  //     //Stream<Either<Failure, Stream<List<TodoModel>>>> todos = _todosRepository.todos().asStream();
  //     failureOrTodos.fold(
  //       (failure) => TodosNotLoaded(), 
  //       (todos) => add(TodosUpdated(todos)));
  //     //failureOrTodos.fold(, (previous, element) => null)
  //       //print(todos);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Stream<TodosState> _mapTodosUpdateToState(TodosUpdated event) async* {
    yield TodosLoaded(event.todos);
  }

  @override
  Future<void> close() {
    _todosSubscription?.cancel();
    return super.close();
  }
}

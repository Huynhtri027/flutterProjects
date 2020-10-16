import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:todosTDD/core/usecases/usecase.dart';
import 'package:todosTDD/features/todosTDD/data/models/todos/todo.dart';
import 'package:todosTDD/features/todosTDD/domain/repositories/todos/todos_repository.dart';
import 'package:todosTDD/features/todosTDD/domain/usecases/todos/todos_usecases.dart';

import 'package:todosTDD/features/todosTDD/presentation/blocs/todos/todo_barrel.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  StreamSubscription
      _todosSubscription; //Only UseCases we are instatiating here.
  DisplayTodoUC _displayTodo;
  AddNewTodoUC _addNewTodo;
  UpdateTodoUC _updateTodo;
  DeleteTodoUC _deleteTodo;

  TodosRepository todosRepository;

  TodosBloc({
    @required DisplayTodoUC displayTodo,
    @required AddNewTodoUC addNewTodo,
    @required UpdateTodoUC updateTodo,
    @required DeleteTodoUC deleteTodo,
  })  : assert(displayTodo != null),
        assert(addNewTodo != null),
        _displayTodo = displayTodo,
        _addNewTodo = addNewTodo,
        _updateTodo = updateTodo,
        _deleteTodo = deleteTodo,
        super(TodosLoading());

  @override
  Stream<TodosState> mapEventToState(
    TodosEvent event,
  ) async* {
    if (event is LoadTodos) {
      yield* _mapLoadTodosToState();
    } else if (event is AddTodo) {
      yield* _mapAddTodoToState(event);
    } else if (event is UpdateTodo) {
      yield* _mapUpdateTodoToState(event);
    } else if (event is DeleteTodo) {
      yield* _mapDeleteTodoToState(event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    } else if (event is TodosUpdated) {
      yield* _mapTodosUpdateToState(event);
    }
  }

  Stream<TodosState> _mapLoadTodosToState() async* {
    _todosSubscription?.cancel();
    final failurOrTodos = _displayTodo.call(NoParams());
    _todosSubscription =
        failurOrTodos.listen((todos) => add(TodosUpdated(todos: todos)));
  }

  Stream<TodosState> _mapAddTodoToState(AddTodo event) async* {
    _addNewTodo.call(TodosParams(todo: event.todo));
  }

  Stream<TodosState> _mapUpdateTodoToState(UpdateTodo event) async* {
    _updateTodo.call(TodosParams(todo: event.updatedTodo));
  }

  Stream<TodosState> _mapDeleteTodoToState(DeleteTodo event) async* {
    _deleteTodo.call(TodosParams(todo: event.todo));
  }

  Stream<TodosState> _mapToggleAllToState() async* {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final allComplete = currentState.todos.every((todo) => todo.complete);
      final List<TodoModel> updatedTodos = currentState.todos
          .map((todo) => todo.copyWith(complete: !allComplete))
          .toList();
      updatedTodos.forEach((updatedTodo) {});
    }
  }

  Stream<TodosState> _mapClearCompletedToState() async* {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final List<TodoModel> completedTodos =
          currentState.todos.where((todo) => todo.complete).toList();
      completedTodos.forEach((completedTodo) {});
    }
  }

  Stream<TodosState> _mapTodosUpdateToState(TodosUpdated event) async* {
    yield TodosLoaded(todos: event.todos);
  }

  @override
  Future<void> close() {
    _todosSubscription?.cancel();
    return super.close();
  }
}

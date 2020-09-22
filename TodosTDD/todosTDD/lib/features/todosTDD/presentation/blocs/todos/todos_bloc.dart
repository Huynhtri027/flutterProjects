import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:todosTDD/features/todosTDD/data/models/todos/todo.dart';
import 'package:todosTDD/features/todosTDD/domain/usecases/todos/addTodos_usecase.dart';
import 'package:todosTDD/features/todosTDD/domain/usecases/todos/deleteTodo_usecase.dart';
import 'package:todosTDD/features/todosTDD/domain/usecases/todos/displayTodos_usecase.dart';
import 'package:todosTDD/features/todosTDD/domain/usecases/todos/updateTodo_usecase.dart';
import 'package:todosTDD/features/todosTDD/presentation/blocs/todos/todo_barrel.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  StreamSubscription
      _todosSubscription; //Only UseCases we are instatiating here.
  DisplayTodosUsecase _displayTodoUsecase;
  AddTodoUsecase _addNewTodoUsecase;
  UpdateTodoUsecase _updateTodoUsecase;
  DeleteTodoUsecase _deleteTodoUsecase;

  TodosBloc({
    @required DisplayTodosUsecase displayTodo,
    @required AddTodoUsecase addNewTodo,
    @required UpdateTodoUsecase updateTodo,
    @required DeleteTodoUsecase deleteTodo,
  })  : assert(displayTodo != null),
        //assert(addNewTodo != null),
        _displayTodoUsecase = displayTodo,
        _addNewTodoUsecase = addNewTodo,
        _updateTodoUsecase = updateTodo,
        _deleteTodoUsecase = deleteTodo,
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
    final failurOrTodos = await _displayTodoUsecase.call(TodosNoParams());
    //List<TodoModel> todosList = failurOrTodos.todosModel.toList() as List<TodoModel>;
    //Stream<List<TodoModel>> streamList = failurOrTodos.todosModel;
    //  _todosSubscription =
    //      failurOrTodos.todosModel.listen((todos) => add(TodosUpdated(todos : failurOrTodos.todosModel)));
    //_todosSubscription = failurOrTodos...add((TodosUpdated(todos: todosList)));
    yield TodosLoaded(
      todos: failurOrTodos.todos,
    );
    
   //_mapTodosUpdateToState();
    
  }

  Stream<TodosState> _mapAddTodoToState(AddTodo event) async* {
    _addNewTodoUsecase.call(TodosParams(todo: event.todo));
  }

  Stream<TodosState> _mapUpdateTodoToState(UpdateTodo event) async* {
    _updateTodoUsecase.call(TodosUParams(todo: event.updatedTodo));
  }

  Stream<TodosState> _mapDeleteTodoToState(DeleteTodo event) async* {
    _deleteTodoUsecase.call(TodosDParams(todo: event.todo));
  }

  Stream<TodosState> _mapToggleAllToState() async* {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final allComplete = currentState.todos.every((todo) => todo.complete);
      final List<TodoModel> updatedTodos = currentState.todos
          .map((todo) => todo.copyWith(complete: !allComplete))
          .toList();
      updatedTodos.forEach((updatedTodo) {
      });
    }
  }

  Stream<TodosState> _mapClearCompletedToState() async* {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final List<TodoModel> completedTodos =
          currentState.todos.where((todo) => todo.complete).toList();
      completedTodos.forEach((completedTodo) {
      });
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

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:todosTDD/core/usecases/usecase.dart';
import 'package:todosTDD/features/todosTDD/data/models/todos/todo.dart';
import 'package:todosTDD/features/todosTDD/domain/usecases/todos/add_new_todo.dart';
import 'package:todosTDD/features/todosTDD/domain/usecases/todos/display_todos.dart';

import 'package:todosTDD/features/todosTDD/presentation/blocs/todos/todo_barrel.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
//  final TodosRepository _todosRepository;   
  StreamSubscription _todosSubscription; //Only UseCases we are instatiating here.
  DisplayTodo _displayTodo;
  AddNewTodo _addNewTodo;

  TodosBloc({
    //@required TodosRepository todosRepository,
    @required DisplayTodo displayTodo,
    @required AddNewTodo addNewTodo,
  }): //assert(todosRepository!=null),
      assert(displayTodo!=null),
      assert(addNewTodo!=null),
      //_todosRepository = todosRepository,
      _displayTodo = displayTodo,
      _addNewTodo = addNewTodo,
      super(TodosLoading());

  /*TodosState get initialState => TodosLoading();*/

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
    _todosSubscription = failurOrTodos.listen(
      (todos) => add(TodosUpdated(todos))); 
  }

  Stream<TodosState> _mapAddTodoToState(AddTodo event) async* {
    
    _addNewTodo.call(Params(todo: event.todo));
  }

  Stream<TodosState> _mapUpdateTodoToState(UpdateTodo event) async* {
    //_todosRepository.updateTodo(event.updatedTodo);
  }

  Stream<TodosState> _mapDeleteTodoToState(DeleteTodo event) async* {
   // _todosRepository.deleteTodo(event.todo);
  }

  Stream<TodosState> _mapToggleAllToState() async* {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final allComplete = currentState.todos.every((todo) => todo.complete);
      final List<TodoModel> updatedTodos = currentState.todos
          .map((todo) => todo.copyWith(complete: !allComplete))
          .toList();
      updatedTodos.forEach((updatedTodo) {
        //_todosRepository.updateTodo(updatedTodo);
      });
    }
  }

  Stream<TodosState> _mapClearCompletedToState() async* {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final List<TodoModel> completedTodos =
          currentState.todos.where((todo) => todo.complete).toList();
      completedTodos.forEach((completedTodo) {
        //_todosRepository.deleteTodo(completedTodo);
      });
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

}

import 'package:flutter/cupertino.dart';
import 'package:todosTDD/features/todosTDD/data/datasources/todos_datasource.dart';
import 'package:todosTDD/features/todosTDD/data/models/todos/todo.dart';
import 'package:todosTDD/features/todosTDD/domain/entities/todos/todo_entity.dart';
import 'package:todosTDD/features/todosTDD/domain/repositories/todos/todos_repository.dart';

class TodosRepositoryImpl implements TodosRepository {
  final TodosDataSource todosDataSource;

  TodosRepositoryImpl({@required this.todosDataSource});

  @override
  Future<void> addNewTodo(TodoEntity todo) async {
    return todosDataSource.addNewTodo(todo);
  }

  @override
  Future<void> deleteTodo(TodoEntity todo) {
    return todosDataSource.deleteTodo(todo);
  }

  @override
  Stream<List<TodoModel>> todos() {
    return todosDataSource.todos();
  }

  @override
  Future<void> updateTodo(TodoEntity todo) {
    return todosDataSource.updateTodo(todo);
  }
}

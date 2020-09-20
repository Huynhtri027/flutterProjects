import 'package:flutter/cupertino.dart';
import 'package:todosTDD/features/todosTDD/data/datasources/todos_datasource.dart';
import 'package:todosTDD/features/todosTDD/data/models/todos/todo.dart';
import 'package:todosTDD/features/todosTDD/domain/repositories/todos/todos_repository.dart';

class TodosRepositoryImpl implements TodosRepository {

  final TodosDataSource todosDataSource;

  TodosRepositoryImpl({@required this.todosDataSource});
  
  
  @override
  Future<void> addNewTodo(TodoModel todo) async{
      return todosDataSource.addNewTodo(todo);
    }
  
    @override
    Future<void> deleteTodo(TodoModel todo) {
      return todosDataSource.deleteTodo(todo);
    }
  
    @override
    Future<List<TodoModel>> todos() {
      return todosDataSource.todos();
    }

    @override
    Future<void> updateTodo(TodoModel todo) {
    return todosDataSource.updateTodo(todo);
  }

}
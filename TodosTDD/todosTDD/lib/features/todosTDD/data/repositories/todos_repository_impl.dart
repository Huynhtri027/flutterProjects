import 'package:flutter/cupertino.dart';
import 'package:todosTDD/features/todosTDD/data/datasources/todos_datasource.dart';
import 'package:todosTDD/features/todosTDD/domain/entities/todos/todo_entity.dart';
import 'package:todosTDD/features/todosTDD/data/models/todos/todo.dart';
import 'package:todosTDD/core/error/failures.dart';
import 'package:dartz/dartz.dart';
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
    Stream<List<TodoModel>> todos() {
      return todosDataSource.todos();
      // return await _getTodos(() {
      //   return todosDataSource.todos();
      // });
    }

    // Future<Either<Failure, List<TodoModel>>> _getTodos(Future<List<TodoModel>> Function() param0) async{
    //   final getTodos = await todos();
    //   return getTodos;
    // }
  
    @override
    Future<void> updateTodo(TodoModel todo) {
    return todosDataSource.updateTodo(todo);
  }

}
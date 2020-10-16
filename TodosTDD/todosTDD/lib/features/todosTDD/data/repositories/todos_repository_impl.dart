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
  Future<Either<Failure, void>> addNewTodo(TodoEntity todo) async{
      return Right(todosDataSource.addNewTodo(todo));
    }
  
    @override
    Future<Either<Failure, void>> deleteTodo(TodoEntity todo) {
      return todosDataSource.deleteTodo(todo);
    }
  
    @override
    Future<Either<Failure, Stream<List<TodoModel>>>> todos() async{
      //return todosDataSource.todos();
      // return await _getTodos(() {
      //   return todosDataSource.todos();
      // });
      try{
        final todos = todosDataSource.todos();
        return Right(todos);
      } on Exception {
        return Left(Failure('Wrong'));
      }
    }

    // Future<Either<Failure, List<TodoModel>>> _getTodos(Future<List<TodoModel>> Function() param0) async{
    //   final getTodos = await todos();
    //   return getTodos;
    // }
  
    @override
    Future<Either<Failure, void>> updateTodo(TodoEntity todo) {
    return todosDataSource.updateTodo(todo);
  }

}
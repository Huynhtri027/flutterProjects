import 'package:todosTDD/features/todosTDD/data/datasources/todos_datasource.dart';
import 'package:todosTDD/features/todosTDD/domain/entities/todos/todo_entity.dart';
import 'package:todosTDD/features/todosTDD/data/models/todos/todo.dart';
import 'package:todosTDD/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:todosTDD/features/todosTDD/domain/repositories/todos/todos_repository.dart';

class TodosRepositoryImpl implements TodosRepository {

  TodosDataSource todosDataSource;
  
  
  @override
  Future<Either<Failure, void>> addNewTodo(TodoModel todo) async{
      return await Right(todosDataSource.addNewTodo(todo));
    }
  
    @override
    Future<Either<Failure, TodoEntity>> deleteTodo(TodoModel todo) {
      // TODO: implement deleteTodo
      throw UnimplementedError();
    }
  
    @override
    Stream<Either<Failure, List<TodoEntity>>> todos() {
      // TODO: implement todos
      throw UnimplementedError();
    }
  
    @override
    Future<Either<Failure, TodoEntity>> updateTodo(TodoModel todo) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }

}
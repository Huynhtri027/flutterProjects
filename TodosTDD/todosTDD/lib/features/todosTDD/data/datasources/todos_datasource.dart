import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todosTDD/features/todosTDD/data/models/todos/todo.dart';

abstract class TodosDataSource {

  Future<void> addNewTodo(TodoModel todo);
  Future<TodoModel> deleteTodo(TodoModel todo);
  Future<TodoModel> todos(TodoModel todo);
  Future<TodoModel> updateTodo(TodoModel todo);
  

}

class TodosDataSourceImpl implements TodosDataSource {

  final todoCollection = FirebaseFirestore.instance.collection('todos');

  @override
  Future<void> addNewTodo(TodoModel todo) {
      return todoCollection.add(todo.toEntity().toDocument());
    }
  
    @override
    Future<TodoModel> deleteTodo(TodoModel todo) {
      // TODO: implement deleteTodo
      throw UnimplementedError();
    }
  
    @override
    Future<TodoModel> todos(TodoModel todo) {
      // TODO: implement todos
      throw UnimplementedError();
    }
  
    @override
    Future<TodoModel> updateTodo(TodoModel todo) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }

}
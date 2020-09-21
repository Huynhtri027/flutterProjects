import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todosTDD/features/todosTDD/data/models/todos/todo.dart';
import 'package:todosTDD/features/todosTDD/domain/entities/todos/todo_entity.dart';
import 'package:todosTDD/features/todosTDD/domain/repositories/todos/todos_repository.dart';

class TodosRepositoryImpl implements TodosRepository {
  //final TodosDataSource todosDataSource;

  //odosRepositoryImpl();

  final todoCollection = Firestore.instance.collection('todos');

  @override
  Future<void> addNewTodo(TodoModel todo) async {
    //return todosDataSource.addNewTodo(todo);
  }

  @override
  Future<void> deleteTodo(TodoModel todo) {
    //return todosDataSource.deleteTodo(todo);
  }

  @override
  Future<List<TodoModel>> todos() async {
    QuerySnapshot qShot = await todoCollection.getDocuments();

    return qShot.documents
        .map((doc) => TodoModel.fromEntity(TodoEntity.fromSnapshot(doc)))
        .toList();
  }

  @override
  Future<void> updateTodo(TodoModel todo) {
    //return todosDataSource.updateTodo(todo);
  }
}

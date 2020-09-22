import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/todos/todo_entity.dart';
import '../../domain/repositories/todos/todos_repository.dart';
import '../models/todos/todo.dart';

class TodosRepositoryImpl implements TodosRepository {
  final todoCollection = Firestore.instance.collection('todos');

  @override
  Future<void> addNewTodo(TodoModel todo) async {
    return todoCollection.add(todo.toEntity().toDocument());
  }

  @override
  Future<void> deleteTodo(TodoModel todo) {
    return todoCollection.document(todo.id).delete();
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
    return todoCollection
        .document(todo.id)
        .updateData(todo.toEntity().toDocument());
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todosTDD/features/todosTDD/data/models/todos/todo.dart';
import 'package:todosTDD/features/todosTDD/domain/entities/todos/todo_entity.dart';

// abstract class TodosDataSource {
//   Future<void> addNewTodo(TodoModel todo);
//   Future<void> deleteTodo(TodoModel todo);
//   Future<List<TodoModel>> todos();
//   Future<void> updateTodo(TodoModel todo);
// }

// class TodosDataSourceImpl implements TodosDataSource {
//   final todoCollection = Firestore.instance.collection('todos');

//   @override
//   Future<void> addNewTodo(TodoModel todo) {
//     return todoCollection.add(todo.toEntity().toDocument());
//   }

//   @override
//   Future<void> deleteTodo(TodoModel todo) {
//     return todoCollection.document(todo.id).delete();
//   }

//   @override
//   Future<List<TodoModel>> todos() async{
//     QuerySnapshot qShot = await todoCollection.getDocuments();

//     return qShot.documents
//         .map((doc) => TodoModel.fromEntity(TodoEntity.fromSnapshot(doc)))
//         .toList();
//   }

//   // @override
//   // Stream<List<TodoModel>> todos() {
//   //   return todoCollection.snapshots().map((snapshot) {
//   //     return snapshot.documents
//   //         .map((doc) => TodoModel.fromEntity(TodoEntity.fromSnapshot(doc)))
//   //         .toList();
//   //   });
//   // }

//   @override
//   Future<void> updateTodo(TodoModel todo) {
//     return todoCollection
//         .document(todo.id)
//         .updateData(todo.toEntity().toDocument());
//   }
// }

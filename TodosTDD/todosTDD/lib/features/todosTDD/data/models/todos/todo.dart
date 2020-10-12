import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/todos/todo_entity.dart';

@immutable
class TodoModel extends TodoEntity{
  final bool complete;
  final String id;
  final String note;
  final String task;

  TodoModel({this.task, this.complete = false, String note = '', String id})    //or we can use here super()
      : this.note = note ?? '',
        this.id = id, super('', '', '', false);


  TodoModel copyWith({bool complete, String id, String note, String task}) {
    return TodoModel(
      task: task ?? this.task,
      complete: complete ?? this.complete,
      id: id ?? this.id,
      note: note ?? this.note,
    );
  }

  @override
  int get hashCode =>
      complete.hashCode ^ task.hashCode ^ note.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoModel &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          task == other.task &&
          note == other.note &&
          id == other.id;

  @override
  String toString() {
    return 'Todo{complete: $complete, task: $task, note: $note, id: $id}';
  }

  TodoEntity toEntity() {
    return TodoEntity(task, id, note, complete);
  }

  static TodoModel fromEntity(TodoEntity entity) {
    return TodoModel(
      task: entity.task,
      complete: entity.complete ?? false,
      note: entity.note,
      id: entity.id,
    );
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      task: json["task"] as String,
      id: json["id"] as String,
      note: json["note"] as String,
      complete: json["complete"] as bool,
    );
  }

  static TodoEntity fromSnapshot(DocumentSnapshot snap) {
    return TodoEntity(
      snap.data['task'],
      snap.documentID,
      snap.data['note'],
      snap.data['complete'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "complete": complete,
      "task": task,
      "note": note,
    };
  }
}

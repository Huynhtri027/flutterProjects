import 'package:meta/meta.dart';

import '../../../domain/entities/todos/todo_entity.dart';

@immutable
class TodoModel extends TodoEntity{
  final bool complete;
  final String id;
  final String note;
  final String task;

  TodoModel(this.task, {this.complete = false, String note = '', String id})
      : this.note = note ?? '',
        this.id = id, super('', '', '', false);


  TodoModel copyWith({bool complete, String id, String note, String task}) {
    return TodoModel(
      task ?? this.task,
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
      entity.task,
      complete: entity.complete ?? false,
      note: entity.note,
      id: entity.id,
    );
  }
}

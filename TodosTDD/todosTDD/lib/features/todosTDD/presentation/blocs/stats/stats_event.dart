import 'package:equatable/equatable.dart';
import 'package:todosTDD/features/todosTDD/data/models/todos/todo.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class UpdateStats extends StatsEvent {
  final List<TodoModel> todos;

  const UpdateStats(this.todos);

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'UpdateStats { todos: $todos }';
}

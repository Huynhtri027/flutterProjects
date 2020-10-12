import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todosTDD/features/todosTDD/data/models/todos/todo.dart';

class TodoItem extends StatefulWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final TodoModel todo;

  TodoItem({
    Key key,
    @required this.onDismissed,
    @required this.onTap,
    @required this.onCheckboxChanged,
    @required this.todo,
  }) : super(key: key);

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('__todo_item_${widget.todo.id}'),
      onDismissed: widget.onDismissed,
      child: ListTile(
        onTap: widget.onTap,
        leading: Checkbox(
          value: widget.todo.complete,
          onChanged: widget.onCheckboxChanged,
        ),
        title: Hero(
          tag: '${widget.todo.id}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              widget.todo.task,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        subtitle: widget.todo.note.isNotEmpty
            ? Text(
                widget.todo.note,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1,
              )
            : null,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todosTDD/features/todosTDD/presentation/blocs/filtered_todos/filtered_todos_barrel.dart';
import 'package:todosTDD/features/todosTDD/presentation/blocs/todos/todo_barrel.dart';
import 'package:todosTDD/features/todosTDD/presentation/screens/details_screen.dart';

import 'delete_todo_snack_bar.dart';
import 'loading_indicator.dart';
import 'todo_item.dart';

class FilteredTodos extends StatefulWidget {
  FilteredTodos({Key key}) : super(key: key);

  @override
  _FilteredTodosState createState() => _FilteredTodosState();
}

class _FilteredTodosState extends State<FilteredTodos> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<TodosBloc, TodosState>(listener: (context, state) {
      if (state is TodosLoaded) {
        BlocProvider.of<TodosBloc>(context)
            .add(TodosUpdated(todos: state.todos));
        print("Todos updated");
      }
    }, child: BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (context, state) {
        print("Building the Todos");
        if (state is FilteredTodosLoading) {
          return LoadingIndicator();
        } else if (state is FilteredTodosLoaded) {
          final todos = state.filteredTodos;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoItem(
                todo: todo,
                onDismissed: (direction) {
                  BlocProvider.of<TodosBloc>(context).add(DeleteTodo(todo));
                  Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
                    todo: todo,
                    onUndo: () =>
                        BlocProvider.of<TodosBloc>(context).add(AddTodo(todo)),
                  ));
                },
                onTap: () async {
                  final removedTodo = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return DetailsScreen(id: todo.id);
                    }),
                  );
                  if (removedTodo != null) {
                    Scaffold.of(context).showSnackBar(
                      DeleteTodoSnackBar(
                        todo: todo,
                        onUndo: () => BlocProvider.of<TodosBloc>(context)
                            .add(AddTodo(todo)),
                      ),
                    );
                  }
                },
                onCheckboxChanged: (_) {
                  BlocProvider.of<TodosBloc>(context).add(
                    UpdateTodo(todo.copyWith(complete: !todo.complete)),
                  );
                },
              );
            },
          );
        } else {
          return Container();
        }
      },
    ));
  }
}

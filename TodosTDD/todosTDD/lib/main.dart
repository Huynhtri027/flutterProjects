import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todosTDD/features/todosTDD/presentation/blocs/todos/todo_barrel.dart';
import 'package:todosTDD/locator.dart';

import 'features/todosTDD/data/models/todos/todo.dart';
import 'features/todosTDD/presentation/blocs/filtered_todos/filtered_todos_barrel.dart';
import 'features/todosTDD/presentation/blocs/simple_bloc_delegate.dart';
import 'features/todosTDD/presentation/blocs/stats/stats.dart';
import 'features/todosTDD/presentation/blocs/tabs/tab.dart';
import 'features/todosTDD/presentation/screens/add_edit_screen.dart';
import 'features/todosTDD/presentation/screens/home_screen.dart';
import 'locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await di.init();
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodosBloc>(
            create: (_) => sl<TodosBloc>()..add(LoadTodos()))
      ],
      child: MaterialApp(
        title: 'TodosTDD Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (context) {
            return BlocBuilder<TodosBloc, TodosState>(
                builder: (context, state) {
              if (state is TodosLoaded) {
                return MultiBlocProvider(providers: [
                  // BlocProvider<TodosBloc>(
                  //     create: (_) => sl<TodosBloc>()..add(LoadTodos())),
                  BlocProvider<TabBloc>(
                    create: (context) => TabBloc(),
                  ),
                  BlocProvider<FilteredTodosBloc>(
                      //create: (_) => sl<FilteredTodosBloc>()),
                      create: (_) => FilteredTodosBloc(
                            todosBloc: BlocProvider.of<TodosBloc>(context),
                          )),
                  BlocProvider<StatsBloc>(
                    create: (context) => StatsBloc(
                      todosBloc: BlocProvider.of<TodosBloc>(context),
                    ),
                  ),
                ], child: HomeScreen());
              }
              return Center(child: CircularProgressIndicator());
            });
          },
          '/addTodo': (context) {
            return AddEditScreen(
              onSave: (task, note) {
                BlocProvider.of<TodosBloc>(context).add(
                  AddTodo(TodoModel(task: task, note: note)),
                );
              },
              isEditing: false,
            );
          },
        },
        //home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

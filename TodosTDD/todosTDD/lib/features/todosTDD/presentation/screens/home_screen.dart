import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todosTDD/features/todosTDD/presentation/blocs/blocs.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Firestore Todos'),
            actions: [
              //FilterButton(visible: activeTab == AppTab.todos),
              //ExtraActions(),
            ],
          ),
          //body: activeTab == AppTab.todos ? FilteredTodos() : Stats(),
          body: Center(
            child: Text('Todos will be displayed here'),
          )
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     Navigator.pushNamed(context, '/addTodo');
          //   },
          //   child: Icon(Icons.add),
          //   tooltip: 'Add Todo',
          // ),
          // bottomNavigationBar: TabSelector(
          //   activeTab: activeTab,
          //   onTabSelected: (tab) =>
          //       BlocProvider.of<TabBloc>(context).add(UpdateTab(tab)),
          // ),
        );
      },
    );
  }
}

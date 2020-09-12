import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todosTDD/features/todosTDD/presentation/blocs/tabs/tab.dart';
import 'package:todosTDD/features/todosTDD/presentation/mods/models.dart';
import 'package:todosTDD/features/todosTDD/presentation/widgets/extra_actions.dart';
import 'package:todosTDD/features/todosTDD/presentation/widgets/filter_button.dart';
import 'package:todosTDD/features/todosTDD/presentation/widgets/filtered_todos.dart';
import 'package:todosTDD/features/todosTDD/presentation/widgets/stats.dart';
import 'package:todosTDD/features/todosTDD/presentation/widgets/tab_selector.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Firestore Todos'),
            actions: [
              // ignore: unrelated_type_equality_checks
              FilterButton(visible: activeTab == AppTab.todos),
              ExtraActions(),
            ],
          ),
          // ignore: unrelated_type_equality_checks
          body: activeTab == AppTab.todos ? FilteredTodos() : Stats(),
          //body: FilteredTodos(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/addTodo');
            },
            child: Icon(Icons.add),
            tooltip: 'Add Todo',
          ),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                BlocProvider.of<TabBloc>(context).add(UpdateTab(tab)),
          ),
        );
      },
    );
  }
}

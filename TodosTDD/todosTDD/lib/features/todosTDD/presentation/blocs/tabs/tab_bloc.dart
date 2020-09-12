import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:todosTDD/features/todosTDD/presentation/blocs/tabs/tab_event.dart';
import 'package:todosTDD/features/todosTDD/presentation/mods/models.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc() : super(AppTab.todos);

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}

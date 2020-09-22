import 'package:get_it/get_it.dart';

import 'features/todosTDD/data/repositories/todos_repository_impl.dart';
import 'features/todosTDD/domain/repositories/todos/todos_repository.dart';
import 'features/todosTDD/domain/usecases/todos/addTodos_usecase.dart';
import 'features/todosTDD/domain/usecases/todos/deleteTodo_usecase.dart';
import 'features/todosTDD/domain/usecases/todos/displayTodos_usecase.dart';
import 'features/todosTDD/domain/usecases/todos/updateTodo_usecase.dart';
import 'features/todosTDD/presentation/blocs/filtered_todos/filtered_todos_barrel.dart';
import 'features/todosTDD/presentation/blocs/todos/todo_barrel.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Repository
  sl.registerLazySingleton<TodosRepository>(() => TodosRepositoryImpl());

  //Usecases
  sl.registerLazySingleton<AddTodoUsecase>(() => AddTodoUsecaseImpl());
  sl.registerLazySingleton<DisplayTodosUsecase>(
      () => DisplayTodosUsecaseImpl());
  sl.registerLazySingleton<UpdateTodoUsecase>(() => UpdateTodoUsecaseImpl());
  sl.registerLazySingleton<DeleteTodoUsecase>(() => DeleteUsecaseImpl());

  //BLocs
  sl.registerFactory(() => TodosBloc(
        displayTodo: sl(),
        addNewTodo: sl(),
        updateTodo: sl(),
        deleteTodo: sl(),
      )); //Passing Usecases instances here
  sl.registerFactory(() => FilteredTodosBloc(todosBloc: sl()));
}

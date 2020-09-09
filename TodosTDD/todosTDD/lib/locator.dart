import 'package:get_it/get_it.dart';
import 'package:todosTDD/features/todosTDD/data/datasources/todos_datasource.dart';
import 'package:todosTDD/features/todosTDD/data/repositories/todos_repository_impl.dart';
import 'package:todosTDD/features/todosTDD/domain/repositories/todos/todos_repository.dart';
import 'package:todosTDD/features/todosTDD/domain/usecases/todos/add_new_todo.dart';
import 'package:todosTDD/features/todosTDD/domain/usecases/todos/display_todos.dart';

final sl = GetIt.instance;

Future<void> init() async {
  
  //Repository
  sl.registerLazySingleton<TodosRepository>(() => TodosRepositoryImpl(
    todosDataSource: sl(),
  ));

  //Usecases
  sl.registerLazySingleton(() => AddNewTodo(sl()));
  sl.registerLazySingleton(() => DisplayTodo(sl()));

  //DataSources
  sl.registerLazySingleton<TodosDataSource>(() => TodosDataSourceImpl());



}
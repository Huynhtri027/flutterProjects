import 'package:get_it/get_it.dart';
import 'package:todosTDD/features/todosTDD/data/repositories/todos_repository_impl.dart';
import 'package:todosTDD/features/todosTDD/domain/repositories/todos/todos_repository.dart';
import 'package:todosTDD/features/todosTDD/domain/usecases/todos/displayTodos_usecase.dart';
import 'features/todosTDD/presentation/blocs/filtered_todos/filtered_todos_barrel.dart';
import 'features/todosTDD/presentation/blocs/todos/todo_barrel.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Repository
  sl.registerLazySingleton<TodosRepository>(() => TodosRepositoryImpl());

  //Usecases
  //sl.registerLazySingleton(() => AddNewTodoUC(sl()));
  sl.registerLazySingleton<DisplayTodosUsecase>(() => DisplayTodosUsecaseImpl());
  //sl.registerLazySingleton(() => UpdateTodoUC(sl()));
  //sl.registerLazySingleton(() => DeleteTodoUC(sl()));

  //DataSources//not necessaryxxx
  //sl.registerLazySingleton<TodosDataSource>(() => TodosDataSourceImpl());

  //BLocs
  sl.registerFactory(() => TodosBloc(
        displayTodo: sl(),
        // addNewTodo: sl(),
        // updateTodo: sl(),
        // deleteTodo: sl(),
      )); //Passing USecases object here
  sl.registerFactory(() => FilteredTodosBloc(todosBloc: sl()));
}

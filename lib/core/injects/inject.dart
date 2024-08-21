import 'package:task_manager/core/db/database.dart';
import 'package:get_it/get_it.dart';
import 'package:task_manager/modules/home/data/data_sources/home_local_datasource.dart';
import 'package:task_manager/modules/home/data/repositories/home_repository_impl.dart';
import 'package:task_manager/modules/home/domain/repositories/home_repository.dart';
import 'package:task_manager/modules/home/domain/use_cases/fetch_task_use_case.dart';
import 'package:task_manager/modules/home/presentation/manager/home_bloc.dart';

final getIt = GetIt.instance;

Future<void> inject() async {
  await injectSource();
  await injectRepository();
  await injectUseCase();
  await injectBloc();
}

Future<void> injectSource() async {
  final db = await AppDatabase.getInstance();

  getIt.registerSingleton<AppDatabase>(db);

  getIt.registerLazySingleton<HomeLocalDatasource>(
    () => HomeLocalDatasourceImpl(
      getIt(),
    ),
  );
}

Future<void> injectRepository() async {
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      getIt(),
    ),
  );
}

Future<void> injectUseCase() async {
  getIt.registerLazySingleton(
    () => FetchTaskUseCase(
      getIt(),
    ),
  );
}

Future<void> injectBloc() async {
  getIt.registerFactory(
    () => HomeBloc(
      getIt(),
    ),
  );
}

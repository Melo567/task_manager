import 'package:dartz/dartz.dart';
import 'package:task_manager/core/db/entities/task.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/core/models/task_model.dart';
import 'package:task_manager/modules/home/data/data_sources/home_local_datasource.dart';
import 'package:task_manager/modules/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeLocalDatasource local;

  HomeRepositoryImpl(this.local);

  @override
  Future<Either<Failure, List<TaskModel>>> getAll() async {
    try {
      final tasks = await local.fetchAll();
      final tasksModel = tasks.map((e) => e.toModel()).toList();
      return Right(tasksModel);
    } catch (e) {
      return Left(LocalDatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<TaskModel>>> search(TaskStatus status) async {
    try {
      final tasks = await local.fetchAllWithTaskStatus(status);
      final tasksModel = tasks.map((e) => e.toModel()).toList();
      return Right(tasksModel);
    } catch (e) {
      return Left(LocalDatabaseFailure());
    }
  }
}

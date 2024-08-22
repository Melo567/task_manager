import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/core/models/task_model.dart';
import 'package:task_manager/modules/detail/data/data_sources/detail_local_datasource.dart';
import 'package:task_manager/modules/detail/domain/repositories/detail_repository.dart';

class DetailRepositoryImpl extends DetailRepository {
  final DetailLocalDatasource local;

  DetailRepositoryImpl(this.local);

  @override
  Future<Either<Failure, void>> deleteTaskById(int id) async {
    try {
      await local.delete(id);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, TaskModel>> findTaskById(int id) async {
    try {
      final task = await local.fetchById(id);
      if (task == null) {
        return Left(ObjectNotFoundFailure());
      }
      return Right(task.toModel());
    } catch (e) {
      return Left(LocalDatabaseFailure());
    }
  }
}

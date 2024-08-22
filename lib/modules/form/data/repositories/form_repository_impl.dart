import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/core/models/task_model.dart';
import 'package:task_manager/modules/form/data/data_sources/form_local_datasource.dart';
import 'package:task_manager/modules/form/domain/repositories/form_repository.dart';

class FormRepositoryImpl extends FormRepository {
  final FormLocalDatasource local;

  FormRepositoryImpl(this.local);

  @override
  Future<Either<Failure, void>> save(TaskModel task) async {
    try {
      await local.insert(task.toEntity());
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, TaskModel>> fetchById(int id) async {
    try {
      final result = await local.findById(id);
      if (result == null) {
        return Left(ObjectNotFoundFailure());
      }
      return Right(result.toModel());
    } catch (e) {
      return Left(LocalDatabaseFailure());
    }
  }
}

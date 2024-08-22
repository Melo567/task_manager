import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/core/models/task_model.dart';

abstract class DetailRepository {
  Future<Either<Failure, TaskModel>> findTaskById(int id);

  Future<Either<Failure, void>> deleteTaskById(int id);
}

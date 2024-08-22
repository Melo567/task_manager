import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/core/models/task_model.dart';

abstract class FormRepository {
  Future<Either<Failure, void>> save(TaskModel task);

  Future<Either<Failure, TaskModel>> fetchById(int id);
}

import 'package:dartz/dartz.dart';
import 'package:task_manager/core/db/entities/task.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/core/models/task_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<TaskModel>>> getAll();

  Future<Either<Failure, List<TaskModel>>> search(TaskStatus status);
}

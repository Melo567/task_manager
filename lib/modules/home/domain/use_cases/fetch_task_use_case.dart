import 'package:dartz/dartz.dart';
import 'package:task_manager/core/db/entities/task.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/core/models/task_model.dart';
import 'package:task_manager/core/utils/use_case.dart';
import 'package:task_manager/modules/home/domain/repositories/home_repository.dart';

class FetchTaskUseCase extends UseCase<List<TaskModel>, TaskStatus?> {
  final HomeRepository repository;

  FetchTaskUseCase(this.repository);

  @override
  Future<Either<Failure, List<TaskModel>>> call(TaskStatus? param) async {
    return param == null
        ? await repository.getAll()
        : await repository.search(param);
  }
}

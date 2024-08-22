import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/core/models/task_model.dart';
import 'package:task_manager/core/utils/use_case.dart';
import 'package:task_manager/modules/detail/domain/repositories/detail_repository.dart';

class FetchTaskUseCase extends UseCase<TaskModel, int> {
  final DetailRepository repository;

  FetchTaskUseCase(this.repository);

  @override
  Future<Either<Failure, TaskModel>> call(int param) async {
    return await repository.findTaskById(param);
  }
}

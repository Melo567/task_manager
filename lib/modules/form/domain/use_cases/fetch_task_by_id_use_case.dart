import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/core/models/task_model.dart';
import 'package:task_manager/core/utils/use_case.dart';
import 'package:task_manager/modules/form/domain/repositories/form_repository.dart';

class FetchTaskByIdUseCase extends UseCase<TaskModel, int> {
  final FormRepository repository;

  FetchTaskByIdUseCase(this.repository);

  @override
  Future<Either<Failure, TaskModel>> call(int param) async {
    return await repository.fetchById(param);
  }
}

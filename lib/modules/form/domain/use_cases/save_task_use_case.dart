import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/core/models/task_model.dart';
import 'package:task_manager/core/utils/use_case.dart';
import 'package:task_manager/modules/form/domain/repositories/form_repository.dart';

class SaveTaskUseCase extends UseCase<void, TaskModel> {
  final FormRepository repository;

  SaveTaskUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(TaskModel param) async {
    print(param);
    return repository.save(param);
  }
}

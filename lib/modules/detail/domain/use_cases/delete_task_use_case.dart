import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/core/utils/use_case.dart';
import 'package:task_manager/modules/detail/domain/repositories/detail_repository.dart';

class DeleteTaskUseCase extends UseCase<void, int> {
  final DetailRepository repository;

  DeleteTaskUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(int param) async {
    return await repository.deleteTaskById(param);
  }
}

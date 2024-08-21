import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';

abstract class UseCase<T, S> {
  Future<Either<Failure, T>> call(S param);
}

part of 'detail_bloc.dart';

enum DetailStatus {
  init,
  loading,
  loaded,
  error,
}

class DetailState extends Equatable {
  final DetailStatus status;
  final TaskModel task;

  const DetailState({
    required this.status,
    required this.task,
  });

  DetailState copyWith({
    DetailStatus? status,
    TaskModel? task,
  }) {
    return DetailState(
      status: status ?? this.status,
      task: task ?? this.task,
    );
  }

  @override
  List<Object> get props => [status, task];
}

final class DetailInitial extends DetailState {
  const DetailInitial({
    super.status = DetailStatus.init,
    super.task = const TaskModel(title: '', description: ''),
  });
}

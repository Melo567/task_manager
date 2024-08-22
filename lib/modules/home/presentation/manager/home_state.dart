part of 'home_bloc.dart';

enum HomeStatus {
  init,
  loading,
  loaded,
  error,
}

class HomeState extends Equatable {
  final HomeStatus status;
  final List<TaskModel> tasks;

  const HomeState({
    required this.tasks,
    required this.status,
  });

  @override
  List<Object> get props => [tasks, status];

  HomeState copyWith({
    HomeStatus? status,
    List<TaskModel>? tasks,
  }) {
    return HomeState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
    );
  }
}

final class HomeInitial extends HomeState {
  const HomeInitial({
    super.tasks = const <TaskModel>[],
    super.status = HomeStatus.init,
  });
}

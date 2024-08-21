part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

class FetchTaskHomeEvent extends HomeEvent {
  final TaskStatus? status;

  const FetchTaskHomeEvent(this.status);

  @override
  List<Object?> get props => [status];
}

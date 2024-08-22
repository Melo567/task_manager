part of 'detail_bloc.dart';

sealed class DetailEvent extends Equatable {
  const DetailEvent();
}

class FetchTaskByIdDetailEvent extends DetailEvent {
  final int id;

  const FetchTaskByIdDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}

class DeleteTaskByIdDetailEvent extends DetailEvent {

  const DeleteTaskByIdDetailEvent();

  @override
  List<Object> get props => [];
}

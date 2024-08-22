part of 'form_bloc.dart';

sealed class FormEvent extends Equatable {
  const FormEvent();
}

class SaveFormEvent extends FormEvent {
  const SaveFormEvent();

  @override
  List<Object> get props => [];
}

class ChangeDueDateFormEvent extends FormEvent {
  final DateTime dateTime;

  const ChangeDueDateFormEvent(this.dateTime);

  @override
  List<Object> get props => [dateTime];
}

class ChangeStatusFormEvent extends FormEvent {
  final TaskStatus status;

  const ChangeStatusFormEvent(this.status);

  @override
  List<Object> get props => [status];
}

class FetchTaskByIdFormEvent extends FormEvent {
  final int id;

  const FetchTaskByIdFormEvent(this.id);

  @override
  List<Object> get props => [id];
}

class NewTaskFormEvent extends FormEvent {
  @override
  List<Object?> get props => [];
}

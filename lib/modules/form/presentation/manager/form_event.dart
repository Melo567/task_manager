part of 'form_bloc.dart';

sealed class FormEvent extends Equatable {
  const FormEvent();
}

class SaveFormEvent extends FormEvent {
  const SaveFormEvent();

  @override
  List<Object> get props => [];
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

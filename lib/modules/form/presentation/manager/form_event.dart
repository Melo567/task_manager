part of 'form_bloc.dart';

sealed class FormEvent extends Equatable {
  const FormEvent();
}

class ChangeTitleFormEvent extends FormEvent {
  final String title;

  const ChangeTitleFormEvent(this.title);

  @override
  List<Object> get props => [title];
}

class ChangeDescriptionFormEvent extends FormEvent {
  final String description;

  const ChangeDescriptionFormEvent(this.description);

  @override
  List<Object> get props => [description];
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

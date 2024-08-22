part of 'form_bloc.dart';

class FormPageState extends Equatable {
  final TaskModel task;

  const FormPageState(this.task);

  @override
  List<Object> get props => [task];
}

final class FormInitial extends FormPageState {
  const FormInitial(super.task);
}

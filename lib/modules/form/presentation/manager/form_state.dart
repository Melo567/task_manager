part of 'form_bloc.dart';

enum FormStatus { init, loading, loaded, error }

class FormPageState extends Equatable {
  final TaskModel task;

  final FormStatus status;

  const FormPageState({required this.status, required this.task});

  @override
  List<Object> get props => [
        task,
        status,
      ];

  FormPageState copyWith({
    TaskModel? task,
    FormStatus? status,
  }) {
    return FormPageState(
      task: task ?? this.task,
      status: status ?? this.status,
    );
  }
}

final class FormInitial extends FormPageState {
  const FormInitial({
    super.status = FormStatus.init,
    super.task = const TaskModel(title: '', description: ''),
  });
}

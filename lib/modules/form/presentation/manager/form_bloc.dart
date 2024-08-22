import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/models/task_model.dart';
import 'package:task_manager/modules/form/domain/use_cases/fetch_task_by_id_use_case.dart';
import 'package:task_manager/modules/form/domain/use_cases/save_task_use_case.dart';

part 'form_event.dart';

part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormPageState> {
  FormBloc(
    this.saveTaskUseCase,
    this.fetchTaskByIdUseCase,
  ) : super(const FormInitial(
          TaskModel(
            title: '',
            description: '',
          ),
        )) {
    on<FetchTaskByIdFormEvent>(_onFetchTask);
    on<SaveFormEvent>(_onSaveTask);
    on<NewTaskFormEvent>(_onNewTask);

    titleController = TextEditingController();
    descriptionController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final GlobalKey<FormState> formKey;

  final SaveTaskUseCase saveTaskUseCase;
  final FetchTaskByIdUseCase fetchTaskByIdUseCase;

  Future<void> _onFetchTask(
    FetchTaskByIdFormEvent event,
    Emitter<FormPageState> emit,
  ) async {
    final result = await fetchTaskByIdUseCase(event.id);
    result.fold(
      (l) {},
      (r) {
        descriptionController.text = r.description;
        titleController.text = r.title;
        emit(FormPageState(r));
      },
    );
  }

  Future<void> _onSaveTask(
    SaveFormEvent event,
    Emitter<FormPageState> emit,
  ) async {
    await saveTaskUseCase(TaskModel(
      title: titleController.text,
      description: descriptionController.text,
    ));
  }

  Future<void> _onNewTask(
    NewTaskFormEvent event,
    Emitter<FormPageState> emit,
  ) async {
    emit(
      const FormInitial(
        TaskModel(
          title: '',
          description: '',
        ),
      ),
    );
    descriptionController.text = '';
    titleController.text = '';
  }
}

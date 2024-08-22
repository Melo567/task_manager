import 'package:equatable/equatable.dart';
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
    on<ChangeTitleFormEvent>(_onChangeTitle);
    on<ChangeDescriptionFormEvent>(_onChangeDescription);
    on<FetchTaskByIdFormEvent>(_onFetchTask);
    on<SaveFormEvent>(_onSaveTask);
  }

  final SaveTaskUseCase saveTaskUseCase;
  final FetchTaskByIdUseCase fetchTaskByIdUseCase;

  Future<void> _onChangeTitle(
    ChangeTitleFormEvent event,
    Emitter<FormPageState> emit,
  ) async {
    final newState = FormPageState(
      state.task.copyWith(
        title: event.title,
      ),
    );
    emit(newState);
  }

  Future<void> _onChangeDescription(
    ChangeDescriptionFormEvent event,
    Emitter<FormPageState> emit,
  ) async {
    final newState = FormPageState(
      state.task.copyWith(
        description: event.description,
      ),
    );
    emit(newState);
  }

  Future<void> _onFetchTask(
    FetchTaskByIdFormEvent event,
    Emitter<FormPageState> emit,
  ) async {
    final result = await fetchTaskByIdUseCase(event.id);
    result.fold(
      (l) {},
      (r) => {
        emit(FormPageState(r)),
      },
    );
  }

  Future<void> _onSaveTask(
    SaveFormEvent event,
    Emitter<FormPageState> emit,
  ) async {
    await saveTaskUseCase(state.task);
  }
}

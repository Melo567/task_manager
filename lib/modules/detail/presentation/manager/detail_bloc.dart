import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/models/task_model.dart';
import 'package:task_manager/modules/detail/domain/use_cases/delete_task_use_case.dart';
import 'package:task_manager/modules/detail/domain/use_cases/fetch_task_use_case.dart';

part 'detail_event.dart';

part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc(this.deleteTaskUseCase, this.fetchTaskUseCase)
      : super(const DetailInitial()) {
    on<FetchTaskByIdDetailEvent>(_onFetch);
    on<DeleteTaskByIdDetailEvent>(_onDelete);
  }

  final DeleteTaskUseCase deleteTaskUseCase;
  final FetchTaskUseCase fetchTaskUseCase;

  Future<void> _onFetch(
    FetchTaskByIdDetailEvent event,
    Emitter<DetailState> emit,
  ) async {
    emit(
      state.copyWith(
        status: DetailStatus.loading,
      ),
    );
    final result = await fetchTaskUseCase(event.id);
    result.fold(
      (l) => emit(
        state.copyWith(
          status: DetailStatus.error,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: DetailStatus.loaded,
          task: r,
        ),
      ),
    );
  }

  Future<void> _onDelete(
    DeleteTaskByIdDetailEvent event,
    Emitter<DetailState> emit,
  ) async {
    await deleteTaskUseCase(state.task.id!);
  }
}

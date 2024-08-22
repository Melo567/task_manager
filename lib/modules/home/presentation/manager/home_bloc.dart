import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/db/entities/task.dart';
import 'package:task_manager/core/models/task_model.dart';
import 'package:task_manager/modules/home/domain/use_cases/fetch_task_use_case.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.fetchTaskUseCase) : super(const HomeInitial()) {
    on<FetchTaskHomeEvent>(_onFetchTasks);
  }

  final FetchTasksUseCase fetchTaskUseCase;

  Future<void> _onFetchTasks(
    FetchTaskHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        status: HomeStatus.loading,
      ),
    );

    final result = await fetchTaskUseCase(event.status);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: HomeStatus.error,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: HomeStatus.loaded,
          tasks: r,
        ),
      ),
    );
  }
}

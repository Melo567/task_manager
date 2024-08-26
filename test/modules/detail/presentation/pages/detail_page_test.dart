import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/db/entities/task.dart';
import 'package:task_manager/core/models/task_model.dart';
import 'package:task_manager/modules/detail/presentation/pages/detail_page.dart';
import 'package:task_manager/modules/detail/presentation/manager/detail_bloc.dart';
import 'package:task_manager/modules/home/presentation/manager/home_bloc.dart';

class MockDetailBloc extends Mock implements DetailBloc {}

class MockHomeBloc extends Mock implements HomeBloc {}

void main() {
  late DetailBloc detailBloc;
  late HomeBloc homeBloc;

  late StreamController<DetailState> detailBlocController;

  setUp(() {
    detailBloc = MockDetailBloc();
    homeBloc = MockHomeBloc();

    detailBlocController = StreamController<DetailState>.broadcast();

    detailBlocController.add(const DetailInitial());

    when(() => detailBloc.stream)
        .thenAnswer((_) => detailBlocController.stream);
    when(() => detailBloc.state).thenReturn(const DetailInitial());
  });

  tearDown(() {
    detailBlocController.close();
  });

  Future<void> createWidgetUnderTest(WidgetTester tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<DetailBloc>.value(value: detailBloc),
          BlocProvider<HomeBloc>.value(value: homeBloc),
        ],
        child: const MaterialApp(
          home: DetailPage(id: 1),
        ),
      ),
    );
  }

  testWidgets(
      'DetailPage shows CircularProgressIndicator when state is loading',
      (WidgetTester tester) async {
    when(() => detailBloc.state).thenReturn(
      const DetailState(
        status: DetailStatus.loading,
        task: TaskModel(
          title: '',
          description: '',
        ),
      ),
    );

    await createWidgetUnderTest(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('DetailPage shows task details when state is loaded',
      (WidgetTester tester) async {
    final task = TaskModel(
      id: 1,
      title: 'Test Task',
      description: 'Test Description',
      status: TaskStatus.done,
      createdAt: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 2)),
    );

    when(() => detailBloc.state).thenReturn(
      DetailState(
        status: DetailStatus.loaded,
        task: task,
      ),
    );

    await createWidgetUnderTest(tester);

    expect(find.text('Test Task'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);
  });

  testWidgets('DetailPage shows error message when state is error',
      (WidgetTester tester) async {
    when(() => detailBloc.state).thenReturn(
      const DetailState(
        status: DetailStatus.error,
        task: TaskModel(
          title: '',
          description: '',
        ),
      ),
    );

    await createWidgetUnderTest(tester);

    expect(find.text("An error has occurred"), findsOneWidget);
  });

  testWidgets('DetailPage shows confirmation dialog on delete icon press',
      (WidgetTester tester) async {
    final task = TaskModel(
      id: 1,
      title: 'Test Task',
      description: 'Test Description',
      status: TaskStatus.progress,
      createdAt: DateTime.now(),
      dueDate: DateTime.now().add(
        const Duration(days: 2),
      ),
    );

    when(() => detailBloc.state).thenReturn(
      DetailState(
        status: DetailStatus.loaded,
        task: task,
      ),
    );

    await createWidgetUnderTest(tester);
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    expect(
      find.text("Are you sure to delete the task ?"),
      findsOneWidget,
    );
  });
}

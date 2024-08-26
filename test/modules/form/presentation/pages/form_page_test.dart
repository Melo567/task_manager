import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_manager/core/models/task_model.dart';
import 'package:task_manager/core/widgets/date_time_picker.dart';
import 'package:task_manager/core/widgets/task_status_modifier_widget.dart';
import 'package:task_manager/modules/form/presentation/pages/form_page.dart';
import 'package:task_manager/modules/form/presentation/manager/form_bloc.dart';
import 'package:task_manager/modules/home/presentation/manager/home_bloc.dart';
import 'package:task_manager/modules/detail/presentation/manager/detail_bloc.dart';

class MockFormBloc extends Mock implements FormBloc {}

class MockHomeBloc extends Mock implements HomeBloc {}

class MockDetailBloc extends Mock implements DetailBloc {}

void main() {
  late FormBloc formBloc;
  late HomeBloc homeBloc;
  late DetailBloc detailBloc;

  late StreamController<FormPageState> formBlocController;

  setUp(() {
    formBloc = MockFormBloc();
    homeBloc = MockHomeBloc();
    detailBloc = MockDetailBloc();

    formBlocController = StreamController<FormPageState>.broadcast();

    when(() => formBloc.formKey).thenReturn(GlobalKey<FormState>());
    when(() => formBloc.titleController).thenReturn(TextEditingController());
    when(() => formBloc.descriptionController)
        .thenReturn(TextEditingController());

    formBlocController.add(const FormInitial());

    when(() => formBloc.stream).thenAnswer((_) => formBlocController.stream);
    when(() => formBloc.state).thenReturn(const FormInitial());
  });

  tearDown(() {
    formBlocController.close();
  });

  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FormBloc>.value(value: formBloc),
        BlocProvider<HomeBloc>.value(value: homeBloc),
        BlocProvider<DetailBloc>.value(value: detailBloc),
      ],
      child: const MaterialApp(
        home: FormPage(),
      ),
    );
  }

  testWidgets(
    'FormPage renders correctly with initial state',
    (WidgetTester tester) async {
      when(() => formBloc.stream)
          .thenAnswer((_) => Stream.value(const FormInitial()));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Container), findsOneWidget);
    },
  );

  testWidgets(
    'FormPage displays loading indicator',
    (WidgetTester tester) async {
      const state = FormPageState(
        task: TaskModel(
          title: '',
          description: '',
        ),
        status: FormStatus.loading,
      );

      when(() => formBloc.stream).thenAnswer((_) => Stream.value(state));

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'FormPage displays loaded',
    (WidgetTester tester) async {
      when(() => formBloc.state).thenReturn(
        const FormPageState(
          task: TaskModel(
            title: '',
            description: '',
          ),
          status: FormStatus.loaded,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(TextFormField), findsNWidgets(4));
      expect(find.byType(TaskStatusModifierWidget), findsOneWidget);
      expect(find.byType(DateTimePicker), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNWidgets(1));
    },
  );
}

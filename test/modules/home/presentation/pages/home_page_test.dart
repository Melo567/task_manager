import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_manager/core/db/entities/task.dart';
import 'package:task_manager/core/models/task_model.dart';
import 'package:task_manager/modules/form/presentation/manager/form_bloc.dart';
import 'package:task_manager/modules/home/presentation/manager/home_bloc.dart';
import 'package:task_manager/modules/home/presentation/pages/home_page.dart';
import 'package:task_manager/modules/home/presentation/widgets/task_item_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class MockFormBloc extends MockBloc<FormEvent, FormPageState>
    implements FormBloc {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockRoute extends Mock implements Route<dynamic> {}

class MockStackRouter extends Mock implements StackRouter {}

class FakePageRouteInfo extends Fake implements PageRouteInfo<dynamic> {}

void main() {
  late MockHomeBloc mockHomeBloc;
  late MockFormBloc mockFormBloc;
  late MockNavigatorObserver mockNavigatorObserver;
  late MockStackRouter mockStackRouter;

  setUp(() {
    mockHomeBloc = MockHomeBloc();
    mockFormBloc = MockFormBloc();
    mockNavigatorObserver = MockNavigatorObserver();
    mockStackRouter = MockStackRouter();
  });

  setUpAll(() {
    registerFallbackValue(MockRoute());
    registerFallbackValue(FakePageRouteInfo());
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(create: (_) => mockHomeBloc),
          BlocProvider<FormBloc>(create: (_) => mockFormBloc),
        ],
        child: StackRouterScope(
          controller: mockStackRouter,
          stateHash: 0,
          child: const HomePage(),
        ),
      ),
      navigatorObservers: [mockNavigatorObserver],
    );
  }

  testWidgets(
      'should display a CircularProgressIndicator when state is loading',
      (WidgetTester tester) async {
    when(() => mockHomeBloc.state).thenReturn(const HomeState(
      status: HomeStatus.loading,
      tasks: [],
    ));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should display a list of tasks when state is loaded with tasks',
      (WidgetTester tester) async {
    final tasks = [
      TaskModel(
        id: 1,
        title: 'Task 1',
        description: 'Test description 1',
        createdAt: DateTime.now(),
      ),
      TaskModel(
        id: 2,
        title: 'Task 2',
        description: 'Test description 2',
        createdAt: DateTime.now(),
        status: TaskStatus.notStared,
      ),
    ];
    when(() => mockHomeBloc.state).thenReturn(HomeState(
      status: HomeStatus.loaded,
      tasks: tasks,
    ));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(TaskItemWidget), findsNWidgets(2));
    expect(find.text('Task 1'), findsOneWidget);
    expect(find.text('Task 2'), findsOneWidget);
  });

  testWidgets('should display a message when state is loaded with empty tasks',
      (WidgetTester tester) async {
    when(() => mockHomeBloc.state).thenReturn(
      const HomeState(
        status: HomeStatus.loaded,
        tasks: [],
      ),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text("You don't have a task"), findsOneWidget);
  });

  testWidgets('should display an error message when state is error',
      (WidgetTester tester) async {
    when(() => mockHomeBloc.state).thenReturn(const HomeState(
      status: HomeStatus.error,
      tasks: [],
    ));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(
      find.text("An error has occurred"),
      findsOneWidget,
    );
  });

  testWidgets(
      'should navigate to FormRoute when floating action button is pressed',
      (WidgetTester tester) async {
    when(() => mockHomeBloc.state).thenReturn(const HomeState(
      status: HomeStatus.init,
      tasks: [],
    ));
    when(() => mockStackRouter.push(any())).thenAnswer(
      (_) async => Future.value(
        Object(),
      ),
    ); // Use a valid Future<Object?>

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    verify(() => mockFormBloc.add(NewTaskFormEvent())).called(1);
    verify(() => mockStackRouter.push(any())).called(1);
  });
}

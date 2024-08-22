import 'package:flutter/material.dart';
import 'package:task_manager/core/injects/inject.dart';
import 'package:task_manager/core/styles/theme.dart';
import 'package:task_manager/core/utils/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/modules/form/presentation/manager/form_bloc.dart';
import 'package:task_manager/modules/home/presentation/manager/home_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final router = AppRouter();
  await inject();
  runApp(
    App(
      appRouter: router,
    ),
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.appRouter,
  });

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<HomeBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<FormBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Task Manager',
        debugShowCheckedModeBanner: false,
        theme: theme,
        routerConfig: appRouter.config(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task_manager/core/styles/theme.dart';
import 'package:task_manager/core/utils/app_router.dart';

void main() {
  final router = AppRouter();
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
    return MaterialApp.router(
      title: 'Task Manager',
      theme: theme,
      routerConfig: appRouter.config(),
    );
  }
}

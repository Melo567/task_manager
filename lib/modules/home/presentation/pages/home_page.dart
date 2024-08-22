import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/db/entities/task.dart';
import 'package:task_manager/core/utils/app_router.dart';
import 'package:task_manager/modules/form/presentation/manager/form_bloc.dart';
import 'package:task_manager/modules/home/presentation/manager/home_bloc.dart';
import 'package:task_manager/modules/home/presentation/widgets/task_item_widget.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const FetchTaskHomeEvent(null));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task Manager',
        ),
        actions: [
          PopupMenuButton<TaskStatus>(
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.filter_alt_outlined,
              ),
            ),
            onSelected: (value) {
              context.read<HomeBloc>().add(
                    FetchTaskHomeEvent(value),
                  );
            },
            itemBuilder: (context) => TaskStatus.values
                .map(
                  (e) => PopupMenuItem<TaskStatus>(
                    value: e,
                    child: Text(e.name),
                  ),
                )
                .toList(),
          )
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch (state.status) {
            case HomeStatus.init:
              return Container();
            case HomeStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case HomeStatus.loaded:
              if (state.tasks.isEmpty) {
                return const Center(
                  child: Text(
                    "Vous n'avez pas encore de tâche",
                  ),
                );
              }
              return ListView.builder(
                itemCount: state.tasks.length,
                itemBuilder: (context, index) {
                  final task = state.tasks[index];
                  return TaskItemWidget(task: task);
                },
              );
            case HomeStatus.error:
              return const Text(
                'Une erreur s\'est produite',
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<FormBloc>().add(NewTaskFormEvent());
          context.router.push(FormRoute());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

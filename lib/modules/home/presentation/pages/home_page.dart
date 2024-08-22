import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/utils/app_router.dart';
import 'package:task_manager/modules/home/presentation/manager/home_bloc.dart';

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
                  return Container();
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
          context.router.push(const FormRoute());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

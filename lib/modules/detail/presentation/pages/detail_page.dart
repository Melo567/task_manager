import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/utils/app_router.dart';
import 'package:task_manager/core/utils/date_time_extension.dart';
import 'package:task_manager/core/widgets/legend_widget.dart';
import 'package:task_manager/modules/detail/presentation/manager/detail_bloc.dart';
import 'package:task_manager/modules/home/presentation/manager/home_bloc.dart';

@RoutePage()
class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.id});

  final int id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<DetailBloc>().add(FetchTaskByIdDetailEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task'),
        actions: [
          IconButton(
            onPressed: () {
              context.router.push(FormRoute(id: widget.id));
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
          IconButton(
            onPressed: () {
              _onShowAlert(context);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          switch (state.status) {
            case DetailStatus.init:
              return Container();
            case DetailStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case DetailStatus.loaded:
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.task.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      state.task.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    LegendWidget(
                      label: "Status",
                      value: state.task.status!.name,
                      fontSize: 13,
                    ),
                    if (state.task.dueDate != null)
                      LegendWidget(
                        label: "Due Date",
                        value: state.task.dueDate!.humanDateTime,
                        fontSize: 13,
                      ),
                    LegendWidget(
                      label: "Created At",
                      value: state.task.createdAt!.humanDateTime,
                      fontSize: 13,
                    ),
                  ],
                ),
              );
            case DetailStatus.error:
              return const Center(
                child: Text(
                  'An error has occurred',
                ),
              );
          }
        },
      ),
    );
  }

  Future<void> _onShowAlert(BuildContext context) async {
    showAdaptiveDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: const Text(
              "Alert",
            ),
            content: const Text(
              "Are you sure to delete the task ?",
            ),
            actions: [
              adaptiveAction(
                context: context,
                onPressed: () {
                  context.router.popForced();
                },
                child: const Text(
                  "Cancel",
                ),
              ),
              adaptiveAction(
                context: context,
                onPressed: () {
                  context.router.popForced();
                  context
                      .read<DetailBloc>()
                      .add(const DeleteTaskByIdDetailEvent());
                  context.read<HomeBloc>().add(const FetchTaskHomeEvent(null));
                  context.router.popForced();
                },
                child: Text(
                  "Delete",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
              )
            ],
          );
        });
  }

  Widget adaptiveAction({
    required BuildContext context,
    required VoidCallback onPressed,
    required Widget child,
  }) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return TextButton(onPressed: onPressed, child: child);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoDialogAction(onPressed: onPressed, child: child);
    }
  }
}

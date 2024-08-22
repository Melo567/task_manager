import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/core/models/task_model.dart';
import 'package:task_manager/core/utils/app_router.dart';
import 'package:task_manager/core/utils/utils.dart';
import 'package:task_manager/core/widgets/legend_widget.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(DetailRoute(id: task.id!));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 108,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    task.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 14,
                        ),
                    maxLines: 1,
                  ),
                  Text(
                    task.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LegendWidget(
                        label: "Created At",
                        value: humanDateFormat(task.createdAt!),
                      ),
                      LegendWidget(
                        label: "Status",
                        value: task.status!.name,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

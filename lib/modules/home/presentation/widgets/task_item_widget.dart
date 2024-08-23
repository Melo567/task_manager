import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/core/db/entities/task.dart';
import 'package:task_manager/core/models/task_model.dart';
import 'package:task_manager/core/utils/app_router.dart';
import 'package:task_manager/core/utils/date_time_extension.dart';
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          task.title,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 14,
                                  ),
                          maxLines: 1,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: getColor(task.status ?? TaskStatus.notStared),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          task.status?.name ?? TaskStatus.notStared.name,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      )
                    ],
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
                      if (task.dueDate != null)
                        LegendWidget(
                          label: "Due Date",
                          value: task.dueDate!.humanDateTime,
                        ),
                      if (task.createdAt != null)
                        LegendWidget(
                          label: "Created at",
                          value: task.createdAt!.humanDateTime,
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

  Color getColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.notStared:
        return Colors.yellow;
      case TaskStatus.progress:
        return Colors.blue;
      case TaskStatus.done:
        return Colors.green;
      default:
        return Colors.white;
    }
  }
}

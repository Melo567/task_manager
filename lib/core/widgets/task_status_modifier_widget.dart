import 'package:flutter/material.dart';
import 'package:task_manager/core/db/entities/task.dart';

class TaskStatusModifierWidget extends StatefulWidget {
  const TaskStatusModifierWidget({
    super.key,
    required this.onChange,
    this.initialValue,
    this.modifiable = true,
  });

  final Function(TaskStatus?) onChange;

  final TaskStatus? initialValue;

  final bool modifiable;

  @override
  State<TaskStatusModifierWidget> createState() =>
      _TaskStatusModifierWidgetState();
}

class _TaskStatusModifierWidgetState extends State<TaskStatusModifierWidget> {
  TaskStatus? _status;

  late final List<TaskStatus> data;

  @override
  void initState() {
    super.initState();
    data = TaskStatus.values.where((e) => e != TaskStatus.all).toList();
    _status = widget.initialValue ?? TaskStatus.notStared;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Status"),
          const SizedBox(
            height: 8.0,
          ),
          Column(
            children: data
                .map(
                  (e) => ListTile(
                    title: Text(e.name),
                    leading: Radio<TaskStatus>(
                      value: e,
                      autofocus: false,
                      groupValue: _status,
                      onChanged: widget.modifiable
                          ? null
                          : (TaskStatus? value) {
                              setState(() {
                                _status = value;
                              });
                              widget.onChange(value);
                            },
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

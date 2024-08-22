import 'package:floor/floor.dart';
import 'package:task_manager/core/models/task_model.dart';

enum TaskStatus {
  all,
  notStared,
  progress,
  done,
}

@entity
class Task {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String title;
  final String description;
  final DateTime createdAt;
  final TaskStatus status;
  final DateTime? dueDate;

  Task({
    this.id,
    required this.title,
    required this.description,
    this.status = TaskStatus.notStared,
    DateTime? createdAt,
    this.dueDate,
  }) : createdAt = createdAt ?? DateTime.now();

  TaskModel toModel() => TaskModel(
        title: title,
        description: description,
        id: id,
        createdAt: createdAt,
        status: status,
        dueDate: dueDate,
      );

  @override
  String toString() {
    return 'Task{id: $id, title: $title, description: $description, createdAt: $createdAt, status: $status, dueDate: $dueDate}';
  }
}

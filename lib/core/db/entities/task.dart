import 'package:floor/floor.dart';

enum TaskStatus {
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

  Task({
    this.id,
    required this.title,
    required this.description,
    this.status = TaskStatus.notStared,
  }) : createdAt = DateTime.now();
}

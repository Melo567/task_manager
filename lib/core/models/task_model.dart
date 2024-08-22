import 'package:equatable/equatable.dart';
import 'package:task_manager/core/db/entities/task.dart';

class TaskModel extends Equatable {
  final int? id;
  final String title;
  final String description;
  final TaskStatus? status;
  final DateTime? createdAt;

  const TaskModel({
    this.id,
    required this.title,
    required this.description,
    this.status,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        status,
        createdAt,
      ];

  Task toEntity() => Task(
        title: title,
        description: description,
        id: id,
        status: status ?? TaskStatus.notStared,
        createdAt: createdAt,
      );

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    TaskStatus? status,
    DateTime? createdAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

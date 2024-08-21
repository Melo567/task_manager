import 'package:floor/floor.dart';

import '../entities/task.dart';

class TaskStatusConvert extends TypeConverter<TaskStatus, String> {
  @override
  TaskStatus decode(String databaseValue) {
    return TaskStatus.values.byName(databaseValue);
  }

  @override
  String encode(TaskStatus value) {
    return value.name;
  }
}

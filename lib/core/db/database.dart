import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:task_manager/core/db/converter/date_time_converter.dart';
import 'package:task_manager/core/db/converter/task_status_convert.dart';
import './dao/task_dao.dart';
import './entities/task.dart';

part 'database.g.dart';

@TypeConverters(
  [
    TaskStatusConvert,
    DateTimeConverter,
    DateTimeNullableConverter,
  ],
)
@Database(
  version: 1,
  entities: [
    Task,
  ],
)
abstract class AppDatabase extends FloorDatabase {
  TaskDao get taskDao;

  static Future<AppDatabase> getInstance() async {
    return await $FloorAppDatabase
        .databaseBuilder('task_manager_database.db')
        .build();
  }
}

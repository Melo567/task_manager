import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import './dao/task_dao.dart';
import './entities/task.dart';

part 'database.g.dart';

@Database(
  version: 1,
  entities: [
    Task,
  ],
)
abstract class AppDatabase extends FloorDatabase {
  TaskDao get taskDao;

  static Future<AppDatabase> getInstance () async {
    return await $FloorAppDatabase.databaseBuilder('task_manager_database.db').build();
  }
}

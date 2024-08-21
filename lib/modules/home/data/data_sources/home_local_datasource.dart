import 'package:task_manager/core/db/database.dart';
import 'package:task_manager/core/db/entities/task.dart';

abstract class HomeLocalDatasource {
  Future<List<Task>> fetchAll();

  Future<List<Task>> fetchAllWithTaskStatus(TaskStatus status);
}

class HomeLocalDatasourceImpl extends HomeLocalDatasource {
  HomeLocalDatasourceImpl(this.db);

  final AppDatabase db;

  @override
  Future<List<Task>> fetchAll() {
    return db.taskDao.findAll();
  }

  @override
  Future<List<Task>> fetchAllWithTaskStatus(TaskStatus status) {
    return db.taskDao.search(status.name);
  }
}

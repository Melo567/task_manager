import 'package:task_manager/core/db/database.dart';
import 'package:task_manager/core/db/entities/task.dart';

sealed class DetailLocalDatasource {
  Future<Task?> fetchById(int id);

  Future<void> delete(int id);
}

class DetailLocalDatasourceImpl extends DetailLocalDatasource {
  final AppDatabase db;

  DetailLocalDatasourceImpl(this.db);

  @override
  Future<void> delete(int id) async {
    await db.taskDao.delete(id);
  }

  @override
  Future<Task?> fetchById(int id) async {
    return db.taskDao.findById(id);
  }
}

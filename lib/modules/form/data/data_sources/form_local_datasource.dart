import 'package:task_manager/core/db/database.dart';
import 'package:task_manager/core/db/entities/task.dart';

sealed class FormLocalDatasource {
  Future<void> insert(Task task);

  Future<Task?> findById(int id);
}

class FormLocalDatasourceImpl extends FormLocalDatasource {
  final AppDatabase db;

  FormLocalDatasourceImpl(this.db);

  @override
  Future<void> insert(Task task) async {
    await db.taskDao.insert(task);
  }

  @override
  Future<Task?> findById(int id) async {
    return await db.taskDao.findById(id);
  }
}

import 'package:floor/floor.dart';
import 'package:task_manager/core/db/entities/task.dart';

@dao
abstract class TaskDao {
  @Query("SELECT * FROM Task ORDER BY dueDate ASC")
  Future<List<Task>> findAll();

  @Query("SELECT * FROM Task WHERE status LIKE :status ORDER BY dueDate ASC")
  Future<List<Task>> search(String status);

  @Query("SELECT * FROM Task WHERE id = :id")
  Future<Task?> findById(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(Task task);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> update(Task task);

  @Query("DELETE FROM Task WHERE id = :id")
  Future<void> delete(int id);
}

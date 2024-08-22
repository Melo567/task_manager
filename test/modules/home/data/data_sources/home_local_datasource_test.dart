import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:task_manager/core/db/dao/task_dao.dart';
import 'package:task_manager/core/db/database.dart';
import 'package:task_manager/core/db/entities/task.dart';
import 'package:task_manager/modules/home/data/data_sources/home_local_datasource.dart';

import 'home_local_datasource_test.mocks.dart';

@GenerateMocks([AppDatabase, TaskDao])
void main() {
  late HomeLocalDatasourceImpl datasource;
  late MockAppDatabase mockAppDatabase;
  late MockTaskDao mockTaskDao;

  setUp(() {
    mockAppDatabase = MockAppDatabase();
    mockTaskDao = MockTaskDao();
    datasource = HomeLocalDatasourceImpl(mockAppDatabase);
    when(mockAppDatabase.taskDao).thenReturn(mockTaskDao);
  });

  group('fetchAll', () {
    test('should return list of tasks from the DAO', () async {
      final taskList = [
        Task(
          id: 1,
          title: 'Test Task',
          description: 'Test description',
        ),
      ];
      when(mockTaskDao.findAll()).thenAnswer((_) async => taskList);

      final result = await datasource.fetchAll();

      expect(result, taskList);
      verify(mockTaskDao.findAll()).called(1);
      verifyNoMoreInteractions(mockTaskDao);
    });
  });

  group('fetchAllWithTaskStatus', () {
    test('should return list of tasks with the specified status from the DAO',
        () async {
      final taskList = [
        Task(
          id: 1,
          title: 'Test Task',
          description: 'Test description',
          status: TaskStatus.done,
        )
      ];
      when(mockTaskDao.search(TaskStatus.done.name))
          .thenAnswer((_) async => taskList);

      final result = await datasource.fetchAllWithTaskStatus(TaskStatus.done);

      expect(result, taskList);
      verify(mockTaskDao.search(TaskStatus.done.name)).called(1);
      verifyNoMoreInteractions(mockTaskDao);
    });
  });
}

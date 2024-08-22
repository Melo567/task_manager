import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:task_manager/core/db/dao/task_dao.dart';
import 'package:task_manager/core/db/database.dart';
import 'package:task_manager/core/db/entities/task.dart';
import 'package:task_manager/modules/detail/data/data_sources/detail_local_datasource.dart';

import 'detail_local_datasource_test.mocks.dart';

@GenerateMocks([AppDatabase, TaskDao])
void main() {
  late DetailLocalDatasourceImpl datasource;
  late MockAppDatabase mockAppDatabase;
  late MockTaskDao mockTaskDao;

  setUp(() {
    mockAppDatabase = MockAppDatabase();
    mockTaskDao = MockTaskDao();
    datasource = DetailLocalDatasourceImpl(mockAppDatabase);

    when(mockAppDatabase.taskDao).thenReturn(mockTaskDao);
  });

  group('fetchById', () {
    test('should return Task when task is found', () async {
      final task = Task(
        id: 1,
        title: 'Test Task',
        description: 'Test description',
      );
      when(mockTaskDao.findById(1)).thenAnswer((_) async => task);

      final result = await datasource.fetchById(1);

      expect(result, equals(task));
      verify(mockTaskDao.findById(1)).called(1);
      verifyNoMoreInteractions(mockTaskDao);
    });

    test('should return null when task is not found', () async {
      when(mockTaskDao.findById(1)).thenAnswer((_) async => null);

      final result = await datasource.fetchById(1);

      expect(result, isNull);
      verify(mockTaskDao.findById(1)).called(1);
      verifyNoMoreInteractions(mockTaskDao);
    });
  });

  group('delete', () {
    test('should call delete on the DAO with the correct id', () async {
      const id = 1;

      await datasource.delete(id);

      verify(mockTaskDao.delete(id)).called(1);
      verifyNoMoreInteractions(mockTaskDao);
    });
  });
}

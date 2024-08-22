import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:task_manager/core/db/dao/task_dao.dart';
import 'package:task_manager/core/db/database.dart';
import 'package:task_manager/core/db/entities/task.dart';
import 'package:task_manager/modules/form/data/data_sources/form_local_datasource.dart';

import 'form_local_datasource_test.mocks.dart';

@GenerateMocks([AppDatabase, TaskDao])
void main() {
  late FormLocalDatasourceImpl datasource;
  late MockAppDatabase mockAppDatabase;
  late MockTaskDao mockTaskDao;

  setUp(() {
    mockAppDatabase = MockAppDatabase();
    mockTaskDao = MockTaskDao();
    datasource = FormLocalDatasourceImpl(mockAppDatabase);

    when(mockAppDatabase.taskDao).thenReturn(mockTaskDao);
  });

  group('insert', () {
    test('should call insert on the DAO with the correct task', () async {
      final task = Task(
        id: 1,
        title: 'Test Task',
        description: 'Test description',
      );

      await datasource.insert(task);

      verify(mockTaskDao.insert(task)).called(1);
      verifyNoMoreInteractions(mockTaskDao);
    });
  });

  group('findById', () {
    test('should return Task when task is found', () async {
      final task = Task(
        id: 1,
        title: 'Test Task',
        description: 'Test description',
      );
      when(mockTaskDao.findById(1)).thenAnswer((_) async => task);

      final result = await datasource.findById(1);

      expect(result, equals(task));
      verify(mockTaskDao.findById(1)).called(1);
      verifyNoMoreInteractions(mockTaskDao);
    });

    test('should return null when task is not found', () async {
      when(mockTaskDao.findById(1)).thenAnswer((_) async => null);

      final result = await datasource.findById(1);

      expect(result, isNull);
      verify(mockTaskDao.findById(1)).called(1);
      verifyNoMoreInteractions(mockTaskDao);
    });
  });
}

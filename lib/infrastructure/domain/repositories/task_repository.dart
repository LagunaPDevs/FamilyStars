import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familystars_2/infrastructure/data_sources/task_data_source.dart';
import 'package:familystars_2/infrastructure/errors/exceptions.dart';
import 'package:familystars_2/infrastructure/models/task.dart';

abstract class TaskRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>>? getUserTasks(
      {required String userId, String? state});
  Future<String?> addNewTaskToChild(Task task);
}

class TaskRepositoryImpl extends TaskRepository {
  final TaskDataSource dataSource;

  TaskRepositoryImpl({required this.dataSource});

  @override
  Future<String?> addNewTaskToChild(Task task) async {
    try {
      final result = await dataSource.addNewTaskToChild(task);
      return result;
    } on TaskException catch (_) {
      return null;
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>>? getUserTasks(
      {required String userId, String? state}) {
    try {
      final result = dataSource.getUserTasks(userId: userId, state: state);
      return result;
    } on TaskException catch (_) {
      return null;
    }
  }
}

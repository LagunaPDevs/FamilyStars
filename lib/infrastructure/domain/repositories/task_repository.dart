import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:familystars_2/infrastructure/errors/result.dart';
import 'package:familystars_2/infrastructure/models/task.dart';

abstract class TaskRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>>? getUserTasks(
      {required String userId, String? state});
  Future<Result<String?>> addNewTaskToChild(Task task);
}


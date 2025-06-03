import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:familystars_2/infrastructure/constants/error_constants.dart';
import 'package:familystars_2/infrastructure/errors/exceptions.dart';
import 'package:familystars_2/infrastructure/models/task.dart';

abstract class TaskDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>>? getUserTasks(
      {required String userId, String? state});
  Future<String?> addNewTaskToChild(Task task);
}

class TaskDataSourceImpl extends TaskDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseCrashlytics firebaseCrashlytics;

  TaskDataSourceImpl(
      {required this.firebaseFirestore, required this.firebaseCrashlytics});

  @override
  Future<String?> addNewTaskToChild(Task task) async {
    try {
      final taskData = task.toJson();
      String? taskId;
      await firebaseFirestore
          .collection("tasks")
          .add(taskData)
          .then((value) async {
        // add task to the child
        await firebaseFirestore.collection("users").doc(task.assigned).update({
          "tasks": FieldValue.arrayUnion([value.id])
        });
        // assign task to parent owner
        await firebaseFirestore.collection("users").doc(task.owner).update({
          "tasks": FieldValue.arrayUnion([value.id])
        });
        // set the task id
        taskId = value.id;
      }).onError((e, stack) {
        firebaseCrashlytics.recordError(e, stack);
        throw TaskException(message: "Error creating new task");
      });
      return taskId;
    } catch (e, stack) {
      firebaseCrashlytics.recordError(e, stack);
      throw TaskException(message: ErrorConstants.unhandled);
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>>? getUserTasks(
      {required String userId, String? state}) {
    try {
      var result = firebaseFirestore
          .collection('tasks')
          .where('assigned', isEqualTo: userId);
      if (state != null) {
        result.where('state', isNotEqualTo: state);
      }
      return result.snapshots();
    } catch (e, stack) {
      firebaseCrashlytics.recordError(e, stack);
      throw TaskException(message: ErrorConstants.unhandled);
    }
  }
}

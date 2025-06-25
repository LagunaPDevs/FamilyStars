import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:familystars_2/infrastructure/constants/error_constants.dart';
import 'package:familystars_2/infrastructure/errors/exceptions.dart';
import 'package:familystars_2/infrastructure/models/task.dart';

abstract class TaskDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>>? getUserTasks(
      {required String userId, String? isNotState});
  Stream<QuerySnapshot<Map<String, dynamic>>>? getParentUserTasks(
      {required String userId, String? isNotState});
  Future<String?> addNewTaskToChild(Task task);
  Future<bool> updateTask(String? taskId, Map<String, dynamic> newData);
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
      final result = await firebaseFirestore
          .collection("tasks")
          .add(taskData)
          .then((value) => value.id)
          .onError((e, stack) {
        firebaseCrashlytics.recordError(e, stack);
        throw TaskException(message: "Error creating new task");
      });
      return result;
    } catch (e, stack) {
      firebaseCrashlytics.recordError(e, stack);
      throw TaskException(message: ErrorConstants.unhandled);
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>>? getUserTasks(
      {required String userId, String? isNotState}) {
    try {
      var result = firebaseFirestore
          .collection('tasks')
          .where('assigned', isEqualTo: userId);
      if (isNotState != null) {
        result = result.where('state', isNotEqualTo: isNotState);
      }
      return result.snapshots();
    } catch (e, stack) {
      firebaseCrashlytics.recordError(e, stack);
      throw TaskException(message: ErrorConstants.unhandled);
    }
  }

  @override
  Future<bool> updateTask(String? taskId, Map<String, dynamic> newData) async {
    try {
      final result = await firebaseFirestore
          .collection("tasks")
          .doc(taskId)
          .update(newData)
          .then((value) => true)
          .onError((e, stack) {
        firebaseCrashlytics.recordError(e, stack);
        throw TaskEventException(message: "Error updating task");
      });
      return result;
    } catch (e, stack) {
      firebaseCrashlytics.recordError(e, stack);
      throw TaskException(message: ErrorConstants.unhandled);
    }
  }
  
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>>? getParentUserTasks({required String userId, String? isNotState}) {
    try {
      var result = firebaseFirestore
          .collection('tasks')
          .where('owner', isEqualTo: userId);
      if (isNotState != null) {
        result = result.where('state', isNotEqualTo: isNotState);
      }
      return result.snapshots();
    } catch (e, stack) {
      firebaseCrashlytics.recordError(e, stack);
      throw TaskException(message: ErrorConstants.unhandled);
    }
  }
}

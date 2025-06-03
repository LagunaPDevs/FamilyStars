import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:familystars_2/infrastructure/constants/error_constants.dart';
import 'package:familystars_2/infrastructure/errors/exceptions.dart';
import 'package:familystars_2/infrastructure/models/event.dart';

abstract class TaskEventDataSource {
  Future<String?> createNewEvent(
      {required TaskEvent event});
  Future<bool> updateEvent(
      {required String eventId, required Map<String, dynamic> newData});
  Stream<QuerySnapshot<Map<String, dynamic>>>? getUserEventList(String userId,
      {int? limit});
}

class TaskEventDataSourceImpl extends TaskEventDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseCrashlytics firebaseCrashlytics;

  TaskEventDataSourceImpl(
      {required this.firebaseCrashlytics, required this.firebaseFirestore});

  @override
  Future<String?> createNewEvent(
      {required TaskEvent event}) async {
    try {
      final result = await firebaseFirestore
          .collection('event')
          .add(event.toJson())
          .then((value) => value.id)
          .onError((e, stack) {
        firebaseCrashlytics.recordError(e, stack);
        throw TaskEventException(message: "Error creating a new event");
      });
      return result;
    } catch (e, stack) {
      firebaseCrashlytics.recordError(e, stack);
      throw TaskEventException(message: ErrorConstants.unhandled);
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>>? getUserEventList(String userId,
      {int? limit}) {
    try {
      final events = firebaseFirestore
          .collection('event')
          .orderBy('created', descending: true)
          .limit(limit ?? 10)
          .where('owner', isEqualTo: userId)
          .snapshots();
      return events;
    } catch (e, stack) {
      firebaseCrashlytics.recordError(e, stack);
      throw TaskEventException(message: ErrorConstants.unhandled);
    }
  }

  @override
  Future<bool> updateEvent(
      {required String eventId, required Map<String, dynamic> newData}) async {
    try {
      final result = await firebaseFirestore
          .collection('event')
          .doc(eventId)
          .update(newData)
          .then((value) => true)
          .onError((e, stack) {
        firebaseCrashlytics.recordError(e, stack);
        throw TaskEventException(message: "Error updating event");
      });
      return result;
    } catch (e, stack) {
      firebaseCrashlytics.recordError(e, stack);
      throw TaskEventException(message: ErrorConstants.unhandled);
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familystars_2/infrastructure/errors/result.dart';
import 'package:familystars_2/infrastructure/models/event.dart';

abstract class TaskEventRepository {
  Future <Result<String?>> createNewEvent(TaskEvent event);
  Future<Result<bool>> updateEvent(
      {required String eventId, required Map<String, dynamic> newData});
  Stream<QuerySnapshot<Map<String, dynamic>>>? getUserEventList(String userId,
      {int? limit});
}


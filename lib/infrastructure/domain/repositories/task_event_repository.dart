import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familystars_2/infrastructure/data_sources/task_event_data_source.dart';
import 'package:familystars_2/infrastructure/errors/exceptions.dart';
import 'package:familystars_2/infrastructure/models/event.dart';

abstract class TaskEventRepository {
  Future<String?> createNewEvent(TaskEvent event);
  Future<bool> updateEvent(
      {required String eventId, required Map<String, dynamic> newData});
  Stream<QuerySnapshot<Map<String, dynamic>>>? getUserEventList(String userId,
      {int? limit});
}

class TaskEventRepositoryImpl extends TaskEventRepository {
  final TaskEventDataSource dataSource;

  TaskEventRepositoryImpl({required this.dataSource});

  @override
  Future<String?> createNewEvent(TaskEvent event) async {
    try {
      final result =
          await dataSource.createNewEvent(event: event);
      return result;
    } on TaskEventException catch (_) {
      return null;
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>>? getUserEventList(String userId,
      {int? limit}) {
    try {
      final result = dataSource.getUserEventList(userId, limit: limit);
      return result;
    } on TaskEventException catch (_) {
      return null;
    }
  }
  
  @override
  Future<bool> updateEvent({required String eventId, required Map<String, dynamic> newData}) async {
    try{
      final result = await dataSource.updateEvent(eventId: eventId, newData: newData);
      return result;
    } on TaskEventException catch(_){
      return false;
    }
  }
}

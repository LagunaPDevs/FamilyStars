import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familystars_2/infrastructure/data_sources/task_event_data_source.dart';
import 'package:familystars_2/infrastructure/errors/exceptions.dart';
import 'package:familystars_2/infrastructure/errors/result.dart';
import 'package:familystars_2/infrastructure/models/event.dart';

abstract class TaskEventRepository {
  Future <Result<String?>> createNewEvent(TaskEvent event);
  Future<Result<bool>> updateEvent(
      {required String eventId, required Map<String, dynamic> newData});
  Stream<QuerySnapshot<Map<String, dynamic>>>? getUserEventList(String userId,
      {int? limit});
}

class TaskEventRepositoryImpl extends TaskEventRepository {
  final TaskEventDataSource dataSource;

  TaskEventRepositoryImpl({required this.dataSource});

  @override
  Future <Result<String?>> createNewEvent(TaskEvent event) async {
    try {
      final result =
          await dataSource.createNewEvent(event: event);
      return Result.ok(result);
    } on TaskEventException catch (e) {
      return Result.error(e);
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
  Future<Result<bool>> updateEvent({required String eventId, required Map<String, dynamic> newData}) async {
    try{
      final result = await dataSource.updateEvent(eventId: eventId, newData: newData);
      return Result.ok(result);
    } on TaskEventException catch(e){
      return Result.error(e);
    }
  }
}

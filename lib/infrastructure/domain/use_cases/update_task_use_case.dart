import 'package:familystars_2/infrastructure/domain/repositories/task_event_repository.dart';

class UpdateTaskUseCase {
  final TaskEventRepository taskEventRepository;

  UpdateTaskUseCase({required this.taskEventRepository});

  Future<bool> updateEvent(
      {required String eventId, required Map<String, dynamic> newData}) async {
    return await taskEventRepository.updateEvent(eventId: eventId, newData: newData);
  }
}

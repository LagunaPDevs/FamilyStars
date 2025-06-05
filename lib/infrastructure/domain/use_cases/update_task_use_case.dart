import 'package:familystars_2/infrastructure/domain/repositories/task_event_repository.dart';
import 'package:familystars_2/infrastructure/errors/result.dart';

class UpdateTaskUseCase {
  final TaskEventRepository taskEventRepository;

  UpdateTaskUseCase({required this.taskEventRepository});

  Future<bool> updateEvent(
      {required String eventId, required Map<String, dynamic> newData}) async {
    final result = await taskEventRepository.updateEvent(
        eventId: eventId, newData: newData);
    switch (result) {
      case Ok():
        return result.result;
      case Error():
        return false;
    }
  }
}

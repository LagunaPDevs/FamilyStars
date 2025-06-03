import 'package:familystars_2/infrastructure/domain/repositories/task_event_repository.dart';
import 'package:familystars_2/infrastructure/domain/repositories/task_repository.dart';

import 'package:familystars_2/infrastructure/models/event.dart';
import 'package:familystars_2/infrastructure/models/task.dart';

class AddNewTaskToChildUseCase {
  final TaskRepository taskRepository;
  final TaskEventRepository taskEventRepository;

  AddNewTaskToChildUseCase(
      {required this.taskEventRepository, required this.taskRepository});

  Future<bool> addNewTaskToChild(Task task, String userId) async {
    final String? taskId = await taskRepository.addNewTaskToChild(task);
    if (taskId != null) {
      final TaskEvent event = TaskEvent.fromTask(task);
      final String? eventId =
          await taskEventRepository.createNewEvent(event, userId);
      if (eventId != null) {
        final result = await taskEventRepository
            .updateEvent(eventId: eventId, newData: {'task_id': task.id});
        return result;
      }
    }
    return false;
  }
}

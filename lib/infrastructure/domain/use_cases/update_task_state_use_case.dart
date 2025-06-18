import 'package:familystars_2/infrastructure/domain/repositories/task_event_repository.dart';
import 'package:familystars_2/infrastructure/domain/repositories/task_repository.dart';

import 'package:familystars_2/infrastructure/errors/result.dart';

import 'package:familystars_2/infrastructure/models/event.dart';
import 'package:familystars_2/infrastructure/models/task.dart';

class UpdateTaskStateUseCase {
  final TaskRepository taskRepository;
  final TaskEventRepository taskEventRepository;

  UpdateTaskStateUseCase(
      {required this.taskRepository, required this.taskEventRepository});

  Future<bool> updateTaskState(
      {required Task task, required String newState}) async {
    final result =
        await taskRepository.updateTask(task.id, {"state": newState});
    task.state = newState;
    switch (result) {
      case Ok():
        final newEventResult = await createNewEvent(task);
        return newEventResult != null ? true : false;
      case Error():
        return false;
    }
  }

  Future<String?> createNewEvent(Task task) async {
    final TaskEvent event = TaskEvent.fromTask(task);
    final result = await taskEventRepository.createNewEvent(event);
    switch (result) {
      case Ok():
        return result.result;
      case Error():
        return null;
    }
  }
}

import 'package:familystars_2/infrastructure/domain/repositories/task_event_repository.dart';
import 'package:familystars_2/infrastructure/domain/repositories/task_repository.dart';
import 'package:familystars_2/infrastructure/domain/repositories/user_repository.dart';

import 'package:familystars_2/infrastructure/models/event.dart';
import 'package:familystars_2/infrastructure/models/task.dart';

class AddNewTaskToChildUseCase {
  final TaskRepository taskRepository;
  final TaskEventRepository taskEventRepository;
  final UserRepository userRepository;

  AddNewTaskToChildUseCase(
      {required this.taskEventRepository,
      required this.taskRepository,
      required this.userRepository});

  Future<bool> addNewTaskToChild(Task task) async {
    final String? taskId = await taskRepository.addNewTaskToChild(task);
    if (taskId != null) {
      final taskAddedToUsers = await _addTaskToParendAndChild(task);
      final eventCreated = await _addTaskEvent(task);
      return taskAddedToUsers && eventCreated;
    }
    return false;
  }

  Future<bool> _addTaskToParendAndChild(Task task) async {
    try {
      if (task.owner == null || task.assigned == null || task.id == null) {
        throw Exception("Invalid task");
      }
      final assignedToParent = await userRepository.assignTaskToUser(
          userId: task.owner!, taskId: task.id!);
      final assignedToChild = await userRepository.assignTaskToUser(
          userId: task.assigned!, taskId: task.id!);
      return assignedToChild && assignedToParent;
    } catch (e) {
      // TODO: HANDLE BETTER ERROR implement Result pattern
      return false;
    }
  }

  Future<bool> _addTaskEvent(Task task) async {
    final TaskEvent event = TaskEvent.fromTask(task);
    final String? eventId = await taskEventRepository.createNewEvent(event);
    if (eventId != null) {
      final result = await taskEventRepository
          .updateEvent(eventId: eventId, newData: {'task_id': task.id});
      return result;
    }
    return false;
  }
}

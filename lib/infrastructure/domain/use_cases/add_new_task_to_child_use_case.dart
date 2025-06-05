import 'package:familystars_2/infrastructure/domain/repositories/task_event_repository.dart';
import 'package:familystars_2/infrastructure/domain/repositories/task_repository.dart';
import 'package:familystars_2/infrastructure/domain/repositories/user_repository.dart';

import 'package:familystars_2/infrastructure/errors/result.dart';

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
    final Result<String?> result = await taskRepository.addNewTaskToChild(task);
    switch (result) {
      case Ok<String?>():
        {
          final taskAddedToUsers = await _addTaskToParendAndChild(task);
          final eventCreated = await _handleAddTaskEvent(task);
          return taskAddedToUsers && eventCreated;
        }
      case Error<String?>():
        return false;
    }
  }

  Future<bool> _addTaskToParendAndChild(Task task) async {
    try {
      if (task.owner == null || task.assigned == null || task.id == null) {
        throw Exception("Invalid task");
      }
      final assignedToParent = await _handleAddTaskToUser("parent", task);
      final assignedToChild = await _handleAddTaskToUser("child", task);

      return assignedToChild && assignedToParent;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _handleAddTaskEvent(Task task) async {
    final TaskEvent event = TaskEvent.fromTask(task);
    final Result<String?> result =
        await taskEventRepository.createNewEvent(event);
    switch (result) {
      case Ok():
        {
          final eventId = result.result;
          if (eventId != null) {
            return await _handleUpdateEvent(eventId, {'task_id': task.id});
          }
          return false;
        }
      case Error():
        return false;
    }
  }

  Future<bool> _handleAddTaskToUser(String userType, Task task) async {
    String? userId = _userIdByUserType(userType, task);
    if (userId == null) return false;
    if (task.id == null) return false;
    final result =
        await userRepository.assignTaskToUser(userId: userId, taskId: task.id!);
    switch (result) {
      case Ok():
        return result.result;
      case Error():
        return false;
    }
  }

  String? _userIdByUserType(String userType, Task task) {
    switch (userType) {
      case 'child':
        return task.assigned;
      case 'parent':
        return task.owner;
    }
    return null;
  }

  Future<bool> _handleUpdateEvent(
      String eventId, Map<String, dynamic> newData) async {
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

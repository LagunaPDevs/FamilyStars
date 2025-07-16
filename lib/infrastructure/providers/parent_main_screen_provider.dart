import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/infrastructure/models/task.dart';

import 'package:familystars_2/infrastructure/models/event.dart';
import 'package:familystars_2/infrastructure/services/shared_preference_services.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';

class ParentMainScreenProvider with ChangeNotifier {
  Ref ref;
  ParentMainScreenProvider(this.ref);

  void openCalendarScreen(BuildContext context) =>
      Navigator.popAndPushNamed(context, RoutesConstants.calendarScreen);
  void openCreateTaskScreen(BuildContext context) =>
      Navigator.pushNamed(context, RoutesConstants.createTaskScreen);

  Stream<List<TaskEvent>>? buildUserEventList() {
    final currentUserId = SharedPreferenceService().getUser();
    if (currentUserId == null) return null;
    final taskEventRepoRef = ref.watch(taskEventRepository);
    final result = taskEventRepoRef.getUserEventList(currentUserId, limit: 15)?.map(
        (snapshot) => snapshot.docs
            .map((doc) => TaskEvent.fromJson(doc.data()))
            .toList());

    return result;
  }

  Future<bool> _updateTaskState(
      {required Task task, required String newState}) async {
    final updateTaskUseCaseRef = ref.watch(updateTaskStateUseCase);
    final result = await updateTaskUseCaseRef.updateTaskState(
        task: task, newState: newState);
    return result;
  }

  Future<bool> _updateChildStars({required Task task}) async {
    final updateUserStarsUseCaseRef = ref.watch(updateUserStarsFromTaskUseCase);
    final result = await updateUserStarsUseCaseRef.updateUserStars(task: task);
    return result;
  }

  Future<bool> handleTaskFromEventComplete({required TaskEvent event}) async {
    Task task = Task.fromEvent(event);
    final taskUpdateResult =
        await _updateTaskState(task: task, newState: AppConstants.completed);
    if (taskUpdateResult) {
      final updateStars = await _updateChildStars(task: task);
      return updateStars;
    }
    return false;
  }
}

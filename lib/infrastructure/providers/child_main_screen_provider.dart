import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/models/task.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/infrastructure/models/event.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';

class ChildMainScreenProvider with ChangeNotifier {
  Ref ref;

  ChildMainScreenProvider(this.ref);

  void openChildCalendarScreen(BuildContext context,
          {required String userPath}) =>
      Navigator.popAndPushNamed(context, RoutesConstants.childCalendarScreen,
          arguments: userPath);

  void openRewardsScreen(BuildContext context, {required String userPath}) =>  Navigator.popAndPushNamed(context, RoutesConstants.rewardsScreen,
              arguments: userPath);
  

  Stream<List<TaskEvent>>? buildChildEventList(String userId) {
    final taskEventRepoRef = ref.watch(taskEventRepository);
    final result = taskEventRepoRef
        .getChildUserEventList(userId, limit: 15)
        ?.map((snapshot) => snapshot.docs
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

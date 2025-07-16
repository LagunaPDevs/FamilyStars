import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';

import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/infrastructure/models/task.dart';

class ParentCalendarScreenProvider extends ChangeNotifier {
  Ref ref;

  ParentCalendarScreenProvider(this.ref);

  CalendarView calendarView = CalendarView.month;

  CalendarController calendarController = CalendarController();

  void setCalendarView(CalendarView view) {
    calendarController.view = view;
    calendarView = view;
    notifyListeners();
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

  Future<bool> handleTaskComplete({required Task task}) async {
    final taskUpdateResult =
        await _updateTaskState(task: task, newState: AppConstants.completed);
    if (taskUpdateResult) {
      final updateStars = await _updateChildStars(task: task);
      return updateStars;
    }
    return false;
  }

  Stream<List<Task>>? buildParentUserTaskList({String? isNotState}) {
    final taskRepositoryRef = ref.watch(taskRepository);
    final firebaseAuthRef = ref.watch(firebaseAuth);
    if (firebaseAuthRef.currentUser?.uid == null) return null;
    final result = taskRepositoryRef
        .getParentUserTasks(userId: firebaseAuthRef.currentUser!.uid, isNotState: isNotState)
        ?.map((snapshot) =>
            snapshot.docs.map((doc) => Task.fromJson(doc.data())).toList());
    return result;
  }
}

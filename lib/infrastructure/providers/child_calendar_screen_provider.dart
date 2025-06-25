import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:familystars_2/infrastructure/dependency_injection.dart';

import 'package:familystars_2/infrastructure/models/task.dart';

class ChildCalendarScreenProvider extends ChangeNotifier {
  Ref ref;

  ChildCalendarScreenProvider(this.ref);

  List<Appointment> appointments = [];
  bool isLoading = false;

  CalendarView calendarView = CalendarView.month;

  CalendarController calendarController = CalendarController();

  void setCalendarView(CalendarView view){
    calendarView = view;
    calendarController.view = view;
    notifyListeners();
  }

  Future<bool> updateTaskState(
      {required Task task, required String newState}) async {
    final updateTaskUseCaseRef = ref.watch(updateTaskStateUseCase);
    final result = await updateTaskUseCaseRef.updateTaskState(
        task: task, newState: newState);
    return result;
  }

  Stream<List<Task>>? buildUserTaskList(
      {required String userId, String? isNotState}) {
    final taskRepositoryRef = ref.watch(taskRepository);
    final result = taskRepositoryRef
        .getUserTasks(userId: userId, isNotState: isNotState)
        ?.map((snapshot) =>
            snapshot.docs.map((doc) => Task.fromJson(doc.data())).toList());
    return result;
  }

}

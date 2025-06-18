import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/app_constants.dart';
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

 List<Appointment> buildAppointmentList(List<Task> taskList)  {
    List<Appointment> list = [];
    for (var task in taskList) {
      String? date = task.date;
      if (date == null) continue;
      List<String> splitted = date.split('/');
      DateTime startTime = _startTimeFromDate(splitted);
      final DateTime endTime = startTime.add(Duration(hours: 23));
      list.add(Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: task.name ?? '',
          color: _appointmentColor(task)));
    }
    return list;
  }

  Color _appointmentColor(Task task) {
    Color color = ColorConstants.yellowColor;
    switch (task.state) {
      case AppConstants.incomplete:
        color = ColorConstants.redColor;
        break;
      case AppConstants.waiting:
        color = ColorConstants.yellowColor;
        break;
      case AppConstants.completed:
        color = ColorConstants.greenColor;
        break;
    }
    return color;
  }

  DateTime _startTimeFromDate(List<String> splittedDate) {
    return DateTime.utc(int.parse(splittedDate[2]), int.parse(splittedDate[1]),
        int.parse(splittedDate[0]), 0, 0, 0);
  }
}

import 'dart:ui';

import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/models/task.dart';

class CalendarUtilities {
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
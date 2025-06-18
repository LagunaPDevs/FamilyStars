import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/infrastructure/models/task_calendar_source.dart';

// It builds a Month calendar which holds all the task of an child user
// If a task is 'Completa' the calendar will show the event on green, if it is
// 'En espera' it will be painted on yellow, otherwise it will be red

class ChildEventCalendar extends StatelessWidget {
  final String userPath;
  const ChildEventCalendar({super.key, required this.userPath});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final childCalendarProvider = ref.watch(childCalendarScreenProvider);
        return StreamBuilder(
          stream: childCalendarProvider.buildUserTaskList(userId: userPath),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                      color: ColorConstants.blueColor));
            }
            List<Appointment> appointments =
                childCalendarProvider.buildAppointmentList(snapshot.data);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 300,
                child: SfCalendar(
                  firstDayOfWeek: 1,
                  controller: childCalendarProvider.calendarController,
                  view: childCalendarProvider.calendarView,
                  dataSource: TaskCalendarSource(appointments),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

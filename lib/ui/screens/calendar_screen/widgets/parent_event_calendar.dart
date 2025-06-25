import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/infrastructure/models/task_calendar_source.dart';
import 'package:familystars_2/infrastructure/utils/calendar_utilities.dart';

// It builds a calendar which holds all the task assigned by a parent
// to multiple children.
// If a task is 'Completa' the calendar will show the event on green, if it is
// 'En espera' it will be painted on yellow, otherwise it will be red

class ParentEventCalendar extends StatelessWidget {
  const ParentEventCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final parentCalendarProviderRef = ref.watch(parentCalendarScreenProvider);
      return StreamBuilder(
        stream: parentCalendarProviderRef.buildParentUserTaskList(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child:
                    CircularProgressIndicator(color: ColorConstants.blueColor));
          }
          List<Appointment> appointments =
              CalendarUtilities().buildAppointmentList(snapshot.data);
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
                height: 300,
                child: SfCalendar(
                    firstDayOfWeek: 1,
                    controller: parentCalendarProviderRef.calendarController,
                    view: parentCalendarProviderRef.calendarView,
                    dataSource: TaskCalendarSource(appointments))),
          );
        },
      );
    });
  }
}

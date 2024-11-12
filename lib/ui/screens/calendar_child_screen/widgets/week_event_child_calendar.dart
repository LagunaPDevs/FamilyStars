import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/utils/task_data_source.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// It builds a Week calendar which holds all the task of an child user
// If a task is 'Completa' the calendar will show the event on green, if it is
// 'En espera' it will be painted on yellow, otherwise it will be red

class WeekEventChildCalendar extends StatefulWidget {
  final String userPath;
  const WeekEventChildCalendar({Key? key, required this.userPath})
      : super(key: key);

  @override
  _WeekEventChildCalendarState createState() => _WeekEventChildCalendarState();
}

class _WeekEventChildCalendarState extends State<WeekEventChildCalendar> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .where('assigned', isEqualTo: widget.userPath)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData)
            return Center(
                child:
                    CircularProgressIndicator(color: ColorConstants.blueColor));
          List data = snapshot.data.docs;
          List<Appointment> appointments = [];
          for (int i = 0; i < data.length; i++) {
            String date = data[i]['date'];
            List splitted = date.split('/');
            DateTime startTime = DateTime.utc(int.parse(splitted[2]),
                int.parse(splitted[1]), int.parse(splitted[0]), 0, 0, 0);
            final DateTime endTime = startTime.add(Duration(hours: 23));
            if (data[i]['state'] == 'Incompleta') {
              appointments.add(Appointment(
                  startTime: startTime,
                  endTime: endTime,
                  subject: data[i]['name'],
                  color: ColorConstants.redColor));
            } else if (data[i]['state'] == 'En espera') {
              appointments.add(Appointment(
                  startTime: startTime,
                  endTime: endTime,
                  subject: data[i]['name'],
                  color: ColorConstants.yellowColor));
            } else if (data[i]['state'] == 'Completa') {
              appointments.add(Appointment(
                  startTime: startTime,
                  endTime: endTime,
                  subject: data[i]['name'],
                  color: ColorConstants.greenColor));
            }
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 300,
              child: SfCalendar(
                  firstDayOfWeek: 1,
                  view: CalendarView.week,
                  dataSource: TaskDataSource(appointments)),
            ),
          );
        });
  }
}

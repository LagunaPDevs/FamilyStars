import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/utils/task_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// It builds a Week calendar which holds all the task assigned by a parent
// to multiple children.
// If a task is 'Completa' the calendar will show the event on green, if it is
// 'En espera' it will be painted on yellow, otherwise it will be red

class WeekEventCalendar extends StatefulWidget {
  const WeekEventCalendar({Key? key}) : super(key: key);

  @override
  _WeekEventCalendarState createState() => _WeekEventCalendarState();
}

class _WeekEventCalendarState extends State<WeekEventCalendar> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool month = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .where('owner', isEqualTo: _firebaseAuth.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          bool changeView = month == false;
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
            if (data[i]['state'] == AppConstants.incomplete) {
              appointments.add(Appointment(
                  startTime: startTime,
                  endTime: endTime,
                  subject: data[i]['name'],
                  color: ColorConstants.redColor));
            } else if (data[i]['state'] == AppConstants.waiting) {
              appointments.add(Appointment(
                  startTime: startTime,
                  endTime: endTime,
                  subject: data[i]['name'],
                  color: ColorConstants.yellowColor));
            } else if (data[i]['state'] == AppConstants.completed) {
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

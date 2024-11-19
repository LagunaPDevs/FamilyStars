import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:familystars_2/ui/commons/child_appbar.dart';

import 'package:familystars_2/ui/screens/calendar_child_screen/widgets/child_task_list_tile.dart';
import 'package:familystars_2/ui/screens/calendar_child_screen/widgets/month_event_child_calendar.dart';
import 'package:familystars_2/ui/screens/calendar_child_screen/widgets/week_event_child_calendar.dart';
import 'package:familystars_2/ui/screens/calendar_screen/widgets/change_calendarview_button.dart';
import 'package:familystars_2/ui/screens/drawer_screen/drawer_child_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This widget represents a screen which holds all child user information about
// past, present or future task

class CalendarChildScreen extends StatefulWidget {
  const CalendarChildScreen({Key? key}) : super(key: key);

  @override
  _CalendarChildScreenState createState() => _CalendarChildScreenState();
}

class _CalendarChildScreenState extends State<CalendarChildScreen> {
  @override
  Widget build(BuildContext context) {
    // User path is received from another screen and paint user information
    final Object? _unreceived = ModalRoute.of(context)!.settings.arguments;
    String userPath = _unreceived.toString();
    return Consumer(builder: (context, watch, child) {
      final calendarProviderRes = watch.read(calendarScreenProvider);
      bool month = calendarProviderRes.monthView;
      return Scaffold(
        drawer: DrawerChildScreen(
          childId: userPath,
        ),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: ChildAppBar(
              childId: userPath,
            )),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              ChangeCalendarViewButton(),
              month
                  ? MonthEventChildEvent(
                      userPath: userPath,
                    )
                  : WeekEventChildCalendar(
                      userPath: userPath,
                    ),
              ChildTaskListTile(userPath: userPath)
            ],
          ),
        )),
      );
    });
  }
}

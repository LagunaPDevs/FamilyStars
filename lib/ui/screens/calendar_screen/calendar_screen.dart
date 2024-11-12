import 'dart:ui';

import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:familystars_2/ui/commons/user_appbar.dart';
import 'package:familystars_2/ui/screens/calendar_screen/widgets/calendar_floating_button.dart';
import 'package:familystars_2/ui/screens/calendar_screen/widgets/change_calendarview_button.dart';
import 'package:familystars_2/ui/screens/calendar_screen/widgets/month_event_calendar.dart';
import 'package:familystars_2/ui/screens/calendar_screen/widgets/task_list_tile.dart';
import 'package:familystars_2/ui/screens/calendar_screen/widgets/week_event_calendar.dart';
import 'package:familystars_2/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This widget represents a screen which holds all parent user information about
// past, present or future task assigned to multiple child

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final calendarProviderRes = watch(calendarScreenProvider);
      bool month = calendarProviderRes.monthView;
      return Scaffold(
        drawer: DrawerScreen(),
        floatingActionButton: CalendarFloatingButton(),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(120), child: UserAppBar()),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              ChangeCalendarViewButton(),
              month ? MonthEventCalendar() : WeekEventCalendar(),
              TasksListTile()
            ],
          ),
        )),
      );
    });
  }
}

import 'package:flutter/material.dart';

import 'package:familystars_2/ui/commons/app_bar_widgets/user_appbar.dart';

import 'package:familystars_2/ui/screens/calendar_screen/widgets/calendar_floating_button.dart';
import 'package:familystars_2/ui/screens/calendar_screen/widgets/parent_calendar_display_button.dart';
import 'package:familystars_2/ui/screens/calendar_screen/widgets/parent_event_calendar.dart';
import 'package:familystars_2/ui/screens/calendar_screen/widgets/task_list_tile.dart';
import 'package:familystars_2/ui/screens/drawer_screen/drawer_screen.dart';

// This widget represents a screen which holds all parent user information about
// past, present or future task assigned to multiple child

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerScreen(),
      floatingActionButton: CalendarFloatingButton(),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(120), child: ParentAppBar()),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ParentCalendarDisplayButton(),
            ParentEventCalendar(),
            TasksListTile()
          ],
        ),
      )),
    );
  }
}

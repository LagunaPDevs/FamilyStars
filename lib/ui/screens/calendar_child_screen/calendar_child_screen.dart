import 'package:flutter/material.dart';

import 'package:familystars_2/ui/commons/child_appbar.dart';
import 'package:familystars_2/ui/screens/calendar_child_screen/widgets/child_calendar_display_button.dart';
import 'package:familystars_2/ui/screens/calendar_child_screen/widgets/child_task_list_tile.dart';
import 'package:familystars_2/ui/screens/calendar_child_screen/widgets/child_event_calendar.dart';
import 'package:familystars_2/ui/screens/drawer_screen/drawer_child_screen.dart';

// This widget represents a screen which holds all child user information about
// past, present or future task

class CalendarChildScreen extends StatelessWidget {
  const CalendarChildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // User path is received from another screen and paint user information
    final Object? unreceived = ModalRoute.of(context)!.settings.arguments;
    String userPath = unreceived.toString();

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
            ChildCalendarDisplayButton(),
            ChildEventCalendar(
              userPath: userPath,
            ),
            ChildTaskListTile(userPath: userPath)
          ],
        ),
      )),
    );
  }
}

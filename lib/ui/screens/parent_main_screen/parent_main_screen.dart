import 'package:flutter/material.dart';

import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/ui/commons/app_bar_widgets/user_appbar.dart';
import 'package:familystars_2/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:familystars_2/ui/screens/parent_main_screen/widgets/add_task_button.dart';
import 'package:familystars_2/ui/screens/parent_main_screen/widgets/calendar_button.dart';
import 'package:familystars_2/ui/screens/parent_main_screen/widgets/parent_event_container.dart';

// This widget represents the main screen of a logged parent user

class ParentMainScreen extends StatelessWidget {
  const ParentMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerScreen(),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(120), child: ParentAppBar()),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: LayoutConstants.generalVerticalSpace,
              ),
              CalendarButton(),
              SizedBox(
                height: LayoutConstants.generalVerticalSpace,
              ),
              ParentEventContainer(),
              SizedBox(
                height: LayoutConstants.generalVerticalSpace,
              ),
              AddTaskButton(),
            ],
          ),
        ),
      ),
    );
  }
}

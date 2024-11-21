import 'dart:ui';

import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/ui/commons/user_appbar.dart';
import 'package:familystars_2/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:familystars_2/ui/screens/main_screen/widgets/add_task_button.dart';
import 'package:familystars_2/ui/screens/main_screen/widgets/calendar_button.dart';
import 'package:familystars_2/ui/screens/main_screen/widgets/parent_event_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This widget represents the main screen of a logged parent user

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Scaffold(
        drawer: DrawerScreen(),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(120), child: UserAppBar()),
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
    });
  }
}

import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/ui/commons/child_appbar.dart';
import 'package:familystars_2/ui/screens/child_main_screen/widgets/child_event_container.dart';
import 'package:familystars_2/ui/screens/drawer_screen/drawer_child_screen.dart';
import 'package:familystars_2/ui/screens/child_main_screen/widgets/child_calendar_button.dart';
import 'package:familystars_2/ui/screens/child_main_screen/widgets/reward_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This widget represent main screen for an specific child user

class ChildMainScreen extends StatefulWidget {
  const ChildMainScreen({Key? key}) : super(key: key);

  @override
  _ChildMainScreenState createState() => _ChildMainScreenState();
}

class _ChildMainScreenState extends State<ChildMainScreen> {
  @override
  Widget build(BuildContext context) {
    // User path is received from another screen and paint user information
    final Object? _unreceived = ModalRoute.of(context)!.settings.arguments;
    String userPath = _unreceived.toString();
    return Consumer(builder: (context, ref, child) {
      return Scaffold(
        drawer: DrawerChildScreen(
          childId: userPath,
        ),
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: ChildAppBar(
              childId: userPath,
            )),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: LayoutConstants.generalVerticalSpace,
                ),
                ChildCalendarButton(userPath: userPath),
                const SizedBox(
                  height: LayoutConstants.generalVerticalSpace,
                ),
                ChildEventContainer(
                  userPath: userPath,
                ),
                const SizedBox(
                  height: LayoutConstants.generalVerticalSpace,
                ),
                RewardButton(
                  userPath: userPath,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

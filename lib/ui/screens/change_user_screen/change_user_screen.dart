import 'package:flutter/material.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';

import 'package:familystars_2/ui/commons/text_widgets/title_text.dart';
import 'package:familystars_2/ui/commons/app_bar_widgets/user_appbar.dart';
import 'package:familystars_2/ui/screens/change_user_screen/widgets/user_grid_list.dart';
import 'package:familystars_2/ui/screens/drawer_screen/drawer_screen.dart';

// This widget allows to a parent user to change between child users

class ChangeUserScreen extends StatelessWidget {
  const ChangeUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerScreen(),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(120), child: ParentAppBar()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: LayoutConstants.generalVerticalSpace,
            ),
            TitleText(title: AppConstants.changeUser),
            SizedBox(
              height: LayoutConstants.generalVerticalSpace,
            ),

            // Retrieve all children of an specific parent

            UserGridList(),
          ],
        ),
      ),
    );
  }
}

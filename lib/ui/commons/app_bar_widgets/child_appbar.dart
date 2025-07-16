import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/image_constants.dart';
import 'package:familystars_2/ui/commons/app_bar_widgets/custom_app_bar.dart';

// This class represents a widget that builds an AppBar representing a child
// user. It works as a menu which user can interact.
// Most of the actions are disable for a this type of user. It only have the
// ability of go to main screen, see company information or change to a parent
// user if the password is known

class ChildAppBar extends StatefulWidget {
  final String childId;
  const ChildAppBar({super.key, required this.childId});

  @override
  State<ChildAppBar> createState() => _ChildAppBarState();

}

class _ChildAppBarState extends State<ChildAppBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final childAppBarProviderRef = ref.watch(childAppBarProvider);
        return CustomAppBar(
            logoPath: ImageConstants.logoKids,
            user: childAppBarProviderRef.getUserById(widget.childId),
            isLoading: childAppBarProviderRef.isLoading,
            widget: starsContainer(
                starsNumber: childAppBarProviderRef.user?.stars ?? '0'));
      },
    );
  }
}

Widget starsContainer({required String starsNumber}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        AppConstants.stars,
        textAlign: TextAlign.end,
        style: TextStyle(
            color: ColorConstants.whiteColor, fontFamily: 'KristenITC'),
      ),
      Text(
        starsNumber,
        textAlign: TextAlign.end,
        style: TextStyle(
            color: ColorConstants.whiteColor,
            fontFamily: 'KristenITC',
            fontSize: 18),
      )
    ],
  );
}

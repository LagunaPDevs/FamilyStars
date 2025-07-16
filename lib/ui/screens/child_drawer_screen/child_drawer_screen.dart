import 'package:familystars_2/ui/screens/child_drawer_screen/widgets/required_password_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/infrastructure/constants/image_constants.dart';
import 'package:familystars_2/ui/commons/drawer/custom_drawer_header.dart';
import 'package:familystars_2/ui/commons/drawer/drawer_menu_item.dart';

// This widget is the drawer menu of a child user, it id is necessary.
// The id is received as an argument.
//
// Most of the functionalities of the menu are not available for a child user
// It can go to child main screen or change user if the required password is
// known

class ChildDrawerScreen extends StatelessWidget {
  final String childId;
  const ChildDrawerScreen({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final childDrawerProviderRef = ref.watch(childDrawerScreenProvider);
        return Drawer(
          child: FutureBuilder(
            future: childDrawerProviderRef.getUser(childId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                        color: ColorConstants.blueColor));
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    CustomDrawerHeader(logoPath: ImageConstants.logoKids),
                    DrawerMenuItem(
                      title: AppConstants.main,
                      onTap: () =>
                          childDrawerProviderRef.openMainScreen(context),
                    ),
                    DrawerMenuItem(
                      title: AppConstants.changeUser,
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => RequiredPasswordDialog(),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child:
                          Divider(height: 1, color: ColorConstants.blueColor),
                    ),
                    DrawerMenuItem(
                      title: AppConstants.logOut,
                      onTap: () => childDrawerProviderRef
                          .displayAccessDeniedDialog(context),
                    ),
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorConstants.blueColor,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

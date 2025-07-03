import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/image_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';

import 'package:familystars_2/ui/commons/drawer/custom_drawer_header.dart';
import 'package:familystars_2/ui/commons/drawer/drawer_menu_item.dart';

// This widget is the drawer menu of a parent user.
//
// Most of the functionalities of the menu are available for a parent user.
// Edit personal information to be implemented on future versions

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final drawerScreenRef = ref.watch(drawerScreenProvider);
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              CustomDrawerHeader(logoPath: ImageConstants.logoParents),
              DrawerMenuItem(
                  onTap: () => drawerScreenRef.openMainScreen(context),
                  title: AppConstants.main),
              DrawerMenuItem(
                title: AppConstants.createUser,
                onTap: () => drawerScreenRef.openCreateUserScreen(context),
              ),
              DrawerMenuItem(
                title: AppConstants.changeUser,
                onTap: () => drawerScreenRef.openChangeUserScreen(context),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Divider(height: 1, color: ColorConstants.blueColor),
              ),
              DrawerMenuItem(
                title: AppConstants.aboutUs,
                onTap: () => drawerScreenRef.openAboutUsScreen(context),
              ),
              DrawerMenuItem(
                title: AppConstants.logOut,
                onTap: () => drawerScreenRef.logout(context),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/image_constants.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:familystars_2/infrastructure/services/firebase_services.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_animated_alert_dialog.dart';
import 'package:flutter/material.dart';

// This widget is the drawer menu of a parent user.
//
// Most of the functionalities of the menu are available for a parent user.
// Edit personal information to be implemented on future versions

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
            decoration: BoxDecoration(
                //color: ColorConstants.blueColor,
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                  ColorConstants.blueColor,
                  ColorConstants.blueGradient
                ])),
            // Actions of the drawer
            // -------------
            child: Container(
                child: Column(
              children: [
                Row(children: [
                  Image.asset(
                    ImageConstants.logoParents,
                    width: 100,
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    AppConstants.menu,
                    style: TextStyle(
                        color: ColorConstants.whiteColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'KristenITC'),
                  )
                ])
              ],
            ))),
        ListTile(
          title: Text(
            AppConstants.main,
            style: TextStyle(fontFamily: 'KristenITC'),
          ),
          onTap: () {
            Navigator.popAndPushNamed(context, RoutesConstants.mainScreen);
          },
        ),
        ListTile(
          title: Text(
            AppConstants.editUser,
            style: TextStyle(fontFamily: 'KristenITC'),
          ),
          onTap: () {
            CustomAnimatedAlertDialog(
                    title: 'Función deshabilitada',
                    content: 'Función desahbilitada en la versión beta',
                    context: context)
                .show();
          },
        ),
        ListTile(
          title: Text(
            AppConstants.createUser,
            style: TextStyle(fontFamily: 'KristenITC'),
          ),
          onTap: () {
            Navigator.popAndPushNamed(
                context, RoutesConstants.createUserScreen);
          },
        ),
        ListTile(
          title: Text(
            AppConstants.changeUser,
            style: TextStyle(fontFamily: 'KristenITC'),
          ),
          onTap: () {
            Navigator.popAndPushNamed(
                context, RoutesConstants.changeUserScreen);
          },
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Divider(height: 1, color: ColorConstants.blueColor),
        ),
        ListTile(
          title: Text(
            AppConstants.aboutUs,
            style: TextStyle(fontFamily: 'KristenITC'),
          ),
          onTap: () {
            Navigator.popAndPushNamed(context, RoutesConstants.aboutUsScreen);
          },
        ),
        ListTile(
          title: Text(
            AppConstants.logOut,
            style: TextStyle(fontFamily: 'KristenITC'),
          ),
          onTap: () async {
            await FirebaseServices.signOutAuthorizedUser();
            Navigator.popAndPushNamed(context, RoutesConstants.loginScreen);
          },
        ),
        // -------------
      ],
    ));
  }
}

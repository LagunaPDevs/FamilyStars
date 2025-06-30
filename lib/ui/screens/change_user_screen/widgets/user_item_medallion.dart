import 'package:flutter/material.dart';

import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:familystars_2/infrastructure/models/user.dart';

class UserItemMedallion extends StatefulWidget {
  final UserModel user;
  const UserItemMedallion({super.key, required this.user});

  @override
  State<UserItemMedallion> createState() => _UserItemMedallionState();
}

class _UserItemMedallionState extends State<UserItemMedallion> {
  String userName = "Unknown";
  @override
  void initState() {
    if (widget.user.name != null && widget.user.name!.isNotEmpty) {
      setState(() => userName = widget.user.name!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.popAndPushNamed(context, RoutesConstants.childMainScreen,
                arguments: widget.user.id);
          },
          child: Container(
            decoration: BoxDecoration(
                color: ColorConstants.generateRandomUserColor(),
                shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text(
                userName[0],
                style: TextStyle(
                    fontFamily: 'KristenITC',
                    fontSize: 28,
                    color: ColorConstants.whiteColor),
              ),
            ),
          ),
        ),
        Text(
          userName,
          style: TextStyle(color: ColorConstants.blueColor),
        ),
      ],
    );
  }
}

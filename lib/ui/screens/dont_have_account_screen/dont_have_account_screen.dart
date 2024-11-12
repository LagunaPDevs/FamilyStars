import 'dart:ui';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Simple widget which leads the user to 'ChooseSignUpMethodScreen'

class DontHaveAccountScreen extends StatefulWidget {
  const DontHaveAccountScreen({Key? key}) : super(key: key);

  @override
  _DontHaveAccountScreenState createState() => _DontHaveAccountScreenState();
}

class _DontHaveAccountScreenState extends State<DontHaveAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(AppConstants.noAccount),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RoutesConstants.chooseSignUpScreen);
            },
            child: Text(
              AppConstants.signUp,
              style: TextStyle(
                  color: ColorConstants.blueColor, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

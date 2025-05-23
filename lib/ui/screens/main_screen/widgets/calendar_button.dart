import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// This widget represents a button that leads to 'CalendarScreen'

class CalendarButton extends StatefulWidget {
  const CalendarButton({super.key});

  @override
  _CalendarButtonState createState() => _CalendarButtonState();
}

class _CalendarButtonState extends State<CalendarButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.popAndPushNamed(context, RoutesConstants.calendarScreen);
        },
        child: Container(
          width: 300,
          height: 100,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    ColorConstants.purpleGradient,
                    ColorConstants.pinkGradient
                  ])),
          child: Center(
              child: Text(
            AppConstants.calendar,
            style: TextStyle(
                color: ColorConstants.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          )),
        ));
  }
}

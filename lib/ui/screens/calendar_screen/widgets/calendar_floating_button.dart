import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:flutter/material.dart';

// This widget permits to parent user to be led to 'CreateTaskScreen'

class CalendarFloatingButton extends StatefulWidget {
  const CalendarFloatingButton({Key? key}) : super(key: key);

  @override
  _CalendarFloatingButtonState createState() => _CalendarFloatingButtonState();
}

class _CalendarFloatingButtonState extends State<CalendarFloatingButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      child: FloatingActionButton(
          backgroundColor: ColorConstants.blueColor,
          onPressed: () {
            Navigator.popAndPushNamed(
                context, RoutesConstants.createTaskScreen);
          },
          child: Text('+',
              style:
                  TextStyle(color: ColorConstants.whiteColor, fontSize: 25))),
    );
  }
}

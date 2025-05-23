import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:flutter/material.dart';

// This widget represents a button that leads to 'CreateTaskScreen'

class AddTaskButton extends StatefulWidget {
  const AddTaskButton({super.key});

  @override
  _AddTaskButtonState createState() => _AddTaskButtonState();
}

class _AddTaskButtonState extends State<AddTaskButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RoutesConstants.createTaskScreen);
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
            AppConstants.addTask,
            style: TextStyle(
                color: ColorConstants.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          )),
        ));
  }
}

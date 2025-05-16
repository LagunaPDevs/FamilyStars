import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:flutter/material.dart';

// Simple widget for title text

class CommonFieldTitle extends StatelessWidget {
  final String title;
  const CommonFieldTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          '$title:',
          style: TextStyle(fontSize: 18, color: ColorConstants.greyColor),
        ));
  }
}

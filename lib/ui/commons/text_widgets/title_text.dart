import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:flutter/material.dart';

// Simple widget for title text

class TitleText extends StatelessWidget {
  final String title;
  const TitleText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: ColorConstants.greyColor,
          fontSize: 20,
          fontWeight: FontWeight.bold),
    );
  }
}

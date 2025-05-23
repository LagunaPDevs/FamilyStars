import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:flutter/material.dart';

// Common text for subtitles

class SubtitleText extends StatelessWidget {
  final String title;
  const SubtitleText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: ColorConstants.greyColor,
        fontSize: 16,
      ),
    );
  }
}

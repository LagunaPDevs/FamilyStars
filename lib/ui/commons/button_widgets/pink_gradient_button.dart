import 'package:flutter/material.dart';

import 'package:familystars_2/infrastructure/constants/color_constants.dart';

class PinkGradientButton extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const PinkGradientButton({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
            ],
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: ColorConstants.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
      ),
    );
  }
}

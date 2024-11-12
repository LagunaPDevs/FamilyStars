import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// General interface button
class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? buttonHeight;
  final Color? disableColor;

  const CustomButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      this.fontSize,
      this.fontWeight,
      this.buttonHeight,
      this.disableColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        minWidth: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(0),
              textStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: ColorConstants.whiteColor,
              )),
          child: Container(
            padding: EdgeInsets.all(8),
            height: buttonHeight,
            decoration: BoxDecoration(
                color: ColorConstants.blueColor,
                borderRadius: BorderRadius.circular(4)),
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: ColorConstants.whiteColor),
              textScaleFactor: 0.9,
            ),
          ),
        ));
  }
}

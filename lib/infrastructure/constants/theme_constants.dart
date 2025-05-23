// Theme of the app defined here

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_constants.dart';

class ThemeConstants {
  static ThemeData lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      primaryColorLight:ColorConstants.whiteColor,
      splashColor:  ColorConstants.whiteColor,
      textSelectionTheme: TextSelectionThemeData(
          cursorColor: ColorConstants.blueColor),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      cardColor: ColorConstants.greyColor,
      scaffoldBackgroundColor:  ColorConstants.whiteColor,
      primaryColor: ColorConstants.blueColor,
      colorScheme: ColorScheme(
              primary: ColorConstants.blackColor,
              secondary:  ColorConstants.blueColor,
              surface: ColorConstants.whiteColor,
              error: ColorConstants.redColor,
              onPrimary: ColorConstants.whiteColor,
              onSecondary: ColorConstants.blueColor,
              onSurface: ColorConstants.blackColor,
              onError: ColorConstants.redColor,
              brightness: Brightness.light)
  );
}

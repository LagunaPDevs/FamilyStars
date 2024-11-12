// Theme of the app defined here

import 'package:flutter/material.dart';

import 'color_constants.dart';

class ThemeConstants {

  static ThemeData lightTheme = ThemeData(
      appBarTheme: AppBarTheme(
        brightness: Brightness.light,
      ),
      primarySwatch: ColorConstants.getMaterialColor(ColorConstants.whiteColor.value, ColorConstants.whiteColor),
      backgroundColor: ColorConstants.getMaterialColor(ColorConstants.whiteColor.value, ColorConstants.whiteColor),
      accentColor: ColorConstants.getMaterialColor(ColorConstants.blueColor.value, ColorConstants.blueColor),
      accentColorBrightness: Brightness.light,
      splashColor: ColorConstants.getMaterialColor(ColorConstants.whiteColor.value, ColorConstants.whiteColor),
      textSelectionTheme: TextSelectionThemeData(cursorColor: ColorConstants.getMaterialColor(ColorConstants.blueColor.value, ColorConstants.blueColor)),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      cardColor: ColorConstants.greyColor,
      scaffoldBackgroundColor: ColorConstants.getMaterialColor(ColorConstants.whiteColor.value, ColorConstants.whiteColor),
      primaryColor: ColorConstants.getMaterialColor(ColorConstants.blueColor.value, ColorConstants.blueColor),
      colorScheme: ColorScheme(primary: ColorConstants.getMaterialColor(ColorConstants.whiteColor.value, ColorConstants.whiteColor), primaryVariant: ColorConstants.getMaterialColor(ColorConstants.greyColor.value, ColorConstants.greyColor), secondary: ColorConstants.getMaterialColor(ColorConstants.blueColor.value, ColorConstants.blueColor), secondaryVariant: ColorConstants.getMaterialColor(ColorConstants.blueColor.value, ColorConstants.blueColor), surface: ColorConstants.whiteColor, background: ColorConstants.whiteColor, error: ColorConstants.redColor, onPrimary: ColorConstants.whiteColor, onSecondary: ColorConstants.blueColor, onSurface: ColorConstants.whiteColor, onBackground: ColorConstants.whiteColor, onError: ColorConstants.redColor, brightness: Brightness.light)
  );

}

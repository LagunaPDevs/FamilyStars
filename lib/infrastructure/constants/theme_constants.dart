// Theme of the app defined here

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_constants.dart';

class ThemeConstants {
  static ThemeData lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      primaryColorLight: ColorConstants.getMaterialColor(
          ColorConstants.whiteColor.value, ColorConstants.whiteColor),
      splashColor: ColorConstants.getMaterialColor(
          ColorConstants.whiteColor.value, ColorConstants.whiteColor),
      textSelectionTheme: TextSelectionThemeData(
          cursorColor: ColorConstants.getMaterialColor(
              ColorConstants.blueColor.value, ColorConstants.blueColor)),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      cardColor: ColorConstants.greyColor,
      scaffoldBackgroundColor: ColorConstants.getMaterialColor(
          ColorConstants.whiteColor.value, ColorConstants.whiteColor),
      primaryColor: ColorConstants.getMaterialColor(
          ColorConstants.blueColor.value, ColorConstants.blueColor),
      colorScheme: ColorScheme(
              primary: ColorConstants.getMaterialColor(
                  ColorConstants.whiteColor.value, ColorConstants.whiteColor),
              secondary: ColorConstants.getMaterialColor(
                  ColorConstants.blueColor.value, ColorConstants.blueColor),
              surface: ColorConstants.whiteColor,
              error: ColorConstants.redColor,
              onPrimary: ColorConstants.whiteColor,
              onSecondary: ColorConstants.blueColor,
              onSurface: ColorConstants.whiteColor,
              onError: ColorConstants.redColor,
              brightness: Brightness.light)
          .copyWith(
              primary: ColorConstants.getMaterialColor(
                  ColorConstants.whiteColor.value, ColorConstants.whiteColor),
              secondary: ColorConstants.getMaterialColor(
                  ColorConstants.blueColor.value, ColorConstants.blueColor)));
}

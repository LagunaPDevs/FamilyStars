import 'dart:math';

import 'package:flutter/material.dart';

class ColorConstants {
  //all the colors of the app are defined here

  static const Color blueColor = Color(0xff377cf7);
  static const Color greyColor = Color(0xff707070);
  static const Color yellowColor = Color(0xffffce00);
  static const Color whiteColor = Color(0xffffffff);
  static const Color greenColor = Color(0xff00ff11);
  static const Color redColor = Color(0xfff24035);
  static const Color facebookColor = Color(0xff1B76F2);
  static const Color googleColor = Color(0xff273B7A);
  static const Color twitterColor = Color(0xff8ADBF3);
  static const Color purpleGradient = Color(0xff967fff);
  static const Color pinkGradient = Color(0xffff7ffa);
  static const Color lightBlueGradient = Color(0xff5a97ef);
  static const Color blueGradient = Color(0xff0d60e0);
  static const Color blackColor = Color(0xff000);

  static Map<int, Color> getSwatch(Color color) {
    final hslColor = HSLColor.fromColor(color);
    final lightness = hslColor.lightness;

    /// if [500] is the default color, there are at LEAST five
    /// steps below [500]. (i.e. 400, 300, 200, 100, 50.) A
    /// divisor of 5 would mean [50] is a lightness of 1.0 or
    /// a color of #ffffff. A value of six would be near white
    /// but not quite.
    const lowDivisor = 6;

    /// if [500] is the default color, there are at LEAST four
    /// steps above [500]. A divisor of 4 would mean [900] is
    /// a lightness of 0.0 or color of #000000
    const highDivisor = 5;

    final lowStep = (1.0 - lightness) / lowDivisor;
    final highStep = lightness / highDivisor;

    return {
      50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
      100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
      200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
      300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
      400: (hslColor.withLightness(lightness + lowStep)).toColor(),
      500: (hslColor.withLightness(lightness)).toColor(),
      600: (hslColor.withLightness(lightness - highStep)).toColor(),
      700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
      800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
      900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
    };
  }

  static MaterialColor getMaterialColor(int colorValue, Color color) {
    return MaterialColor(colorValue, getSwatch(color));
  }

  static Color generateRandomUserColor() {
    List<Color> randomColorList = [
      const Color(0xffff7ffa),
      const Color(0xff7fff8c),
      const Color(0xffff9d7f),
      const Color(0xff7ffff0),
      const Color(0xfffffd7f),
      const Color(0xff967fff),
    ];
    var random = Random();

    int randomNumber(int min, int max) => min + random.nextInt(max - min);

    return randomColorList[randomNumber(0, randomColorList.length - 1)];
  }
}

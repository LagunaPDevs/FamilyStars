import 'dart:ui';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:flutter/material.dart';

// Simple widget which holds title text for ActivationCodeScreen

class ActivationCodeTitle extends StatelessWidget {
  const ActivationCodeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        children: [
          SizedBox(
            height: LayoutConstants.verticalTopSpace,
          ),
          Text(
            AppConstants.verification,
            style: TextStyle(
                color: ColorConstants.blueColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: LayoutConstants.generalSubtitleSpace,
          ),
          Text(AppConstants.verificationText,
              textAlign: TextAlign.center,
              style: TextStyle(color: ColorConstants.greyColor, fontSize: 16)),
        ],
      )),
    );
  }
}

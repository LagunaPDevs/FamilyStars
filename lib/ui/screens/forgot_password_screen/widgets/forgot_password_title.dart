import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:flutter/material.dart';

// Simple widget which all title and text of 'ForgotPasswordScreen'

class ForgotPasswordTitle extends StatelessWidget {
  const ForgotPasswordTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: LayoutConstants.verticalTopSpace,
            ),
            Text(AppConstants.titleForgotPassword),
            SizedBox(height: LayoutConstants.generalVerticalSpace),
          ],
        ),
      ),
    );
  }
}

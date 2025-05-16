import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/image_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Simple widget that contains image and title of 'LoginScreen'

class LoginTitleScreen extends StatelessWidget {
  const LoginTitleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: LayoutConstants.verticalTopSpace,
            ),
            Image.asset(
              ImageConstants.logoFamilyStars,
              width: 150,
              height: 150,
            ),
            SizedBox(
              height: LayoutConstants.generalSubtitleSpace,
            ),
            Text(
              AppConstants.welcome,
              style: TextStyle(
                  color: ColorConstants.blueColor,
                  fontSize: 20,
                  fontFamily: 'KristenITC'),
            ),
            SizedBox(height: LayoutConstants.generalVerticalSpace),
          ],
        ),
      ),
    );
  }
}

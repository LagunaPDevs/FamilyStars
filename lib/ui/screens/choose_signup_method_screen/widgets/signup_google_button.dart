import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/image_constants.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:familystars_2/infrastructure/services/firebase_services.dart';
import 'package:familystars_2/ui/commons/button_widgets/custom_flat_button_with_preicon.dart';
import 'package:flutter/material.dart';

// This widget led to user to register with 'Google' credentials

class SignUpGoogleButton extends StatefulWidget {
  const SignUpGoogleButton({super.key});

  @override
  _SignUpGoogleButtonState createState() => _SignUpGoogleButtonState();
}

class _SignUpGoogleButtonState extends State<SignUpGoogleButton> {
  @override
  Widget build(BuildContext context) {
    return CustomFlatButtonWithPreIcon.icon(
      label: Text(
        AppConstants.signUpGoogle,
        textScaleFactor: 1,
      ),
      minWidth: double.infinity,
      icon: SizedBox(
        height: 50,
        child: Image.asset(
          ImageConstants.googleIcon,
          width: 30,
          height: 30,
        ),
      ),
      onPressed: () async {
        bool isLoggedIn =
            await FirebaseServices.signUpWithFirebaseGoogleCredentials(context);
        if (isLoggedIn) {
          Navigator.pushReplacementNamed(
              context, RoutesConstants.passwordScreen);
        }
      },
      color: ColorConstants.googleColor,
    );
  }
}

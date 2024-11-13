import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/image_constants.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:familystars_2/infrastructure/services/firebase_services.dart';
import 'package:familystars_2/ui/commons/button_widgets/custom_flat_button_with_preicon.dart';
import 'package:flutter/material.dart';

// This widget led to user to register with 'Facebook' credentials

class SignUpFacebookButton extends StatefulWidget {
  const SignUpFacebookButton({Key? key}) : super(key: key);

  @override
  _SignUpFacebookButtonState createState() => _SignUpFacebookButtonState();
}

class _SignUpFacebookButtonState extends State<SignUpFacebookButton> {
  @override
  Widget build(BuildContext context) {
    return CustomFlatButtonWithPreIcon.icon(
      label: const Text(
        AppConstants.signUpFacebook,
        textScaler: TextScaler.linear(1),
      ),
      minWidth: double.infinity,
      icon: SizedBox(
        height: 50,
        child: Image.asset(
          ImageConstants.facebookIcon,
          width: 25,
          height: 25,
        ),
      ),
      onPressed: () async {
        bool isLoggedIn =
            await FirebaseServices.signUpWithFirebaseFacebookCredentials(
                context);
        if (isLoggedIn) {
          Navigator.pushReplacementNamed(
              context, RoutesConstants.passwordScreen);
        }
      },
      color: ColorConstants.facebookColor,
    );
  }
}

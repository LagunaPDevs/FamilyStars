import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/image_constants.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_animated_alert_dialog.dart';
import 'package:familystars_2/ui/commons/button_widgets/custom_flat_button_with_preicon.dart';
import 'package:flutter/material.dart';

// This widget led to user to register with 'Twitter' credentials
// Currently this functionality is not available

class SignUpTwitterButton extends StatefulWidget {
  const SignUpTwitterButton({Key? key}) : super(key: key);

  @override
  _SignUpTwitterButtonState createState() => _SignUpTwitterButtonState();
}

class _SignUpTwitterButtonState extends State<SignUpTwitterButton> {
  @override
  Widget build(BuildContext context) {
    return CustomFlatButtonWithPreIcon.icon(
      label: Text(
        AppConstants.signUpTwitter,
        textScaleFactor: 1,
      ),
      minWidth: double.infinity,
      icon: Container(
        height: 50,
        child: Image.asset(
          ImageConstants.twitterIcon,
          width: 25,
          height: 25,
        ),
      ),
      onPressed: () {
        CustomAnimatedAlertDialog(
                title: 'Función deshabilitada',
                content: 'Función desahbilitada en la versión beta',
                context: context)
            .show();
      },
      color: ColorConstants.twitterColor,
    );
  }
}

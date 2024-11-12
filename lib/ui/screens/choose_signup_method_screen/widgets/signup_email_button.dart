import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/image_constants.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:familystars_2/ui/commons/button_widgets/custom_flat_button_with_preicon.dart';
import 'package:flutter/material.dart';

// This widget led to user to 'RegistrationScreen' where a email-password
// account can be created

class SignUpEmailButton extends StatefulWidget {
  const SignUpEmailButton({Key? key}) : super(key: key);

  @override
  _SignUpEmailButtonState createState() => _SignUpEmailButtonState();
}

class _SignUpEmailButtonState extends State<SignUpEmailButton> {
  @override
  Widget build(BuildContext context) {
    return CustomFlatButtonWithPreIcon.icon(
      label: Text(
        AppConstants.signUpMail,
        textScaleFactor: 1,
      ),
      minWidth: double.infinity,
      icon: Container(
        height: 50,
        child: Image.asset(
          ImageConstants.userIcon,
          width: 20,
          height: 20,
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, RoutesConstants.registrationScreen);
      },
      color: ColorConstants.greyColor,
    );
  }
}

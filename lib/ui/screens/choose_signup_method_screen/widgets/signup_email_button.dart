import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/image_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';

import 'package:familystars_2/ui/commons/button_widgets/custom_flat_button_with_preicon.dart';

// This widget led to user to 'RegistrationScreen' where a email-password
// account can be created

class SignUpEmailButton extends StatelessWidget {
  const SignUpEmailButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final chooseSignUpMethodProviderRef =
            ref.watch(chooseSignUpMethodScreenProvider);
        return CustomFlatButtonWithPreIcon.icon(
          label: Text(
            AppConstants.signUpMail,
            textScaler: TextScaler.linear(1),
          ),
          minWidth: double.infinity,
          icon: SizedBox(
            height: 50,
            child: Image.asset(
              ImageConstants.userIcon,
              width: 20,
              height: 20,
            ),
          ),
          onPressed: () =>
              chooseSignUpMethodProviderRef.onEmailSignUpClick(context),
          color: ColorConstants.greyColor,
        );
      },
    );
  }
}

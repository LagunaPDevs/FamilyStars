import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/ui/commons/button_widgets/custom_button.dart';


class PasswordScreenButton extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  const PasswordScreenButton({super.key, this.formKey});

  @override
  State<PasswordScreenButton> createState() => _PasswordScreenButtonState();
}

class _PasswordScreenButtonState extends State<PasswordScreenButton> {

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final passwordProviderRes = ref.watch(passwordScreenProvider);

        return CustomButton(
          onPressed: () async {
            // If fields are completed it check email-password
            if (widget.formKey!.currentState!.validate()) {
            
              // Set user password
              bool setPassword = await passwordProviderRes.updateUserPassword();
              if (setPassword && context.mounted) {
                // Go to main page if everything correct
                Navigator.pushReplacementNamed(
                    context, RoutesConstants.parentMainScreen);
              }
            }
          },
          title: AppConstants.signIn,
          buttonHeight: 50,
          fontSize: 18,
        );
      },
    );
  }
}

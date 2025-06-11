import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';

import 'package:familystars_2/infrastructure/dependency_injection.dart';

// Widget that permits to user go forward with registration process if the
// correspondent fields are validated

class RegistrationNextButton extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  const RegistrationNextButton({super.key, this.formKey});

  @override
  _RegistrationNextButtonState createState() => _RegistrationNextButtonState();
}

class _RegistrationNextButtonState extends State<RegistrationNextButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final registrationProviderRes = ref.watch(registrationScreenProvider);
        return GestureDetector(
          onTap: () async {
            if (widget.formKey!.currentState!.validate()) {
              final handleNext =
                  await registrationProviderRes.handleNext(context);
              if (handleNext == false && context.mounted) {
                _registrationErrorScaffold(context);
              }
            }
          },
          child: SizedBox(
            child: Row(
              children: [
                Text(
                  AppConstants.next,
                  style: TextStyle(
                      color: ColorConstants.blueColor,
                      fontFamily: 'KristenITC'),
                ),
                Icon(
                  Icons.navigate_next,
                  color: ColorConstants.blueColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

_registrationErrorScaffold(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: ColorConstants.purpleGradient.withValues(alpha: 0.5),
    content: SizedBox(
        height: 100,
        child: Text(AppConstants.errorRegisteringUser,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
  ));
}

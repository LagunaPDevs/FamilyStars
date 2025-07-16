import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';

// This widget complete the registration process if all fields are valid
// It only appears in the last step of registration

class RegistrationDoneButton extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  const RegistrationDoneButton({super.key, this.formKey});

  @override
  _RegistrationDoneButtonState createState() => _RegistrationDoneButtonState();
}

class _RegistrationDoneButtonState extends State<RegistrationDoneButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final registrationProviderRes = ref.watch(registrationScreenProvider);
      return GestureDetector(
        onTap: () async {
          // If form is validated save user information to email-password
          // account previously validated
          if (widget.formKey!.currentState!.validate()) {
            final register =
                await registrationProviderRes.updateUserData(context);
            if (!register && context.mounted) {_registrationErrorScaffold(context);}
          }
        },
        child: SizedBox(
          child: Row(
            children: [
              Text(
                AppConstants.done,
                style: TextStyle(
                    color: ColorConstants.greenColor, fontFamily: 'KristenITC'),
              ),
              Icon(Icons.check, color: ColorConstants.greenColor),
            ],
          ),
        ),
      );
    });
  }
}

_registrationErrorScaffold(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: ColorConstants.purpleGradient.withValues(alpha: 0.5),
    content: SizedBox(
        height: 100,
        child: Text(AppConstants.errorUpdatingUser,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
  ));
}

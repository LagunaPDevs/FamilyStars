import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

// Widget that permits to user go backward with registration process

class RegistrationPreviousButton extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  const RegistrationPreviousButton({Key? key, this.formKey}) : super(key: key);

  @override
  _RegistrationPreviousButtonState createState() =>
      _RegistrationPreviousButtonState();
}

class _RegistrationPreviousButtonState
    extends State<RegistrationPreviousButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final registrationProviderRes = watch(registrationScreenProvider);
        int activeStep = registrationProviderRes.activeStep;
        return GestureDetector(
          onTap: () {
            if (activeStep > 0) {
              setState(() {
                // Go backward
                registrationProviderRes.setActiveStepDown();
              });
            }
          },
          child: Container(
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios_outlined,
                  color: ColorConstants.blueColor,
                ),
                Text(
                  AppConstants.previous,
                  style: TextStyle(
                      color: ColorConstants.blueColor,
                      fontFamily: 'KristenITC'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

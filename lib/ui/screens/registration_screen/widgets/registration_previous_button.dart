import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Widget that permits to user go backward with registration process

class RegistrationPreviousButton extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  const RegistrationPreviousButton({super.key, this.formKey});

  @override
  _RegistrationPreviousButtonState createState() =>
      _RegistrationPreviousButtonState();
}

class _RegistrationPreviousButtonState
    extends State<RegistrationPreviousButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final registrationProviderRes = ref.watch(registrationScreenProvider);
        return GestureDetector(
          onTap: () => registrationProviderRes.setActiveStepDown(),
          child: SizedBox(
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

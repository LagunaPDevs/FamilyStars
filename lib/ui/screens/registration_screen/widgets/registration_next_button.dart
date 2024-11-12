import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:familystars_2/infrastructure/services/firebase_services.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

// Widget that permits to user go forward with registration process if the
// correspondent fields are validated

class RegistrationNextButton extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  const RegistrationNextButton({Key? key, this.formKey}) : super(key: key);

  @override
  _RegistrationNextButtonState createState() => _RegistrationNextButtonState();
}

class _RegistrationNextButtonState extends State<RegistrationNextButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final registrationProviderRes = watch(registrationScreenProvider);
        int activeStep = registrationProviderRes.activeStep;
        int upperBound = registrationProviderRes.upperBound;
        return GestureDetector(
          onTap: () {
            if (widget.formKey!.currentState!.validate()) {
              String email = registrationProviderRes.emailController.text;
              if (activeStep < upperBound) {
                setState(() {
                  // Go forward
                  registrationProviderRes.setActiveStepUp();
                  if (registrationProviderRes.activeStep == 1) {
                    // If user is in step one (email-password), the interface
                    // will lead it previously to 'ActivationCodeScreen' to
                    // validate the OTP sent to it email account

                    CustomLoading.progressDialog(true, context);
                    FirebaseServices.verifyUserEmailAccount(
                        context, email, RoutesConstants.activationCodeScreen);
                    CustomLoading.progressDialog(false, context);
                  }
                });
              }
            }
          },
          child: Container(
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

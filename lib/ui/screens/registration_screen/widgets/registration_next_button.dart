import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/infrastructure/services/firebase_services.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        int activeStep = registrationProviderRes.activeStep;
        int upperBound = registrationProviderRes.upperBound;

        return GestureDetector(
          onTap: () async {
            if (widget.formKey!.currentState!.validate()) {
              String email = registrationProviderRes.emailController.text;
              if (activeStep < upperBound) {
                if (registrationProviderRes.activeStep == 0) {
                  // If email-password registration valid continue with the registration
                  CustomLoading.progressDialog(true, context);
                  final registrationSuccess = await FirebaseServices
                      .registerUserWithFirebaseEmailCredentials(context, email,
                          registrationProviderRes.passwordController.text);
                  CustomLoading.progressDialog(false, context);
                  if (!registrationSuccess) return;
                }
                setState(() {
                  // Go forward
                  registrationProviderRes.setActiveStepUp();
                });
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

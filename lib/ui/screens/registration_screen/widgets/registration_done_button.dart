import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:familystars_2/infrastructure/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

// This widget complete the registration process if all fields are valid
// It only appears in the last step of registration

class RegistrationDoneButton extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  const RegistrationDoneButton({Key? key, this.formKey}) : super(key: key);

  @override
  _RegistrationDoneButtonState createState() => _RegistrationDoneButtonState();
}

class _RegistrationDoneButtonState extends State<RegistrationDoneButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final registrationProviderRes = watch(registrationScreenProvider);
      return GestureDetector(
        onTap: () async {
          // If form is validated save user information to email-password
          // account previously validated
          if (widget.formKey!.currentState!.validate()) {
            String email = registrationProviderRes.emailController.text;
            String password = registrationProviderRes.passwordController.text;
            String name = registrationProviderRes.fullnameController.text;
            String familiar = registrationProviderRes.familiarText;
            String dob = registrationProviderRes.dobText;

            // If it succeed lead to the registered user to it main screen
            await FirebaseServices.saveUserData(
                    name: name,
                    email: email,
                    password: password,
                    familiar: familiar,
                    date_of_birth: dob)
                .then((value) => Navigator.popAndPushNamed(
                    context, RoutesConstants.mainScreen));
          }
        },
        child: Container(
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

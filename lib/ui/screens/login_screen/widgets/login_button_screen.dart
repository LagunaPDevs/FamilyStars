import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/infrastructure/services/firebase_services.dart';
import 'package:familystars_2/ui/commons/button_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This widget permits a user to be logged in the app with email-password
class LoginButtonScreen extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  const LoginButtonScreen({super.key, this.formKey});

  @override
  _LoginButtonScreenState createState() => _LoginButtonScreenState();
}

class _LoginButtonScreenState extends State<LoginButtonScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final logInProviderRes = ref.watch(logInScreenProvider);
      return CustomButton(
        onPressed: () async {
          // If fields are completed it check email-password
          if (widget.formKey!.currentState!.validate()) {
            String email = logInProviderRes.emailController.text;
            String password = logInProviderRes.passwordController.text;

            bool loginSucceed =
                await FirebaseServices.loginUserWithFirebaseEmailCredentials(
                    context, email, password);
            if (loginSucceed) {
              Navigator.popAndPushNamed(context, RoutesConstants.mainScreen);
            }
          }
        },
        title: AppConstants.signIn,
        buttonHeight: 50,
        fontSize: 18,
      );
    });
  }
}

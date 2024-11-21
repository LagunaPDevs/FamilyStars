import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:familystars_2/infrastructure/services/firebase_services.dart';
import 'package:familystars_2/ui/commons/button_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This widget permit reset password action for an specific email

class ForgotPasswordButton extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  const ForgotPasswordButton({Key? key, this.formKey}) : super(key: key);

  @override
  _ForgotPasswordButtonState createState() => _ForgotPasswordButtonState();
}

class _ForgotPasswordButtonState extends State<ForgotPasswordButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final forgotPasswordProviderRef = ref.watch(forgotPasswordScreenProvider);
      return CustomButton(
        onPressed: () async {
          // if field is completed it sends a reactivation email
          if (widget.formKey!.currentState!.validate()) {
            String emailId = forgotPasswordProviderRef.emailController.text;
            //FIREBASE OPERATION
            await FirebaseServices.resetPassword(context, emailId);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: ColorConstants.purpleGradient.withOpacity(0.5),
              content: SizedBox(
                  height: 100,
                  child: Text(AppConstants.resetPwd,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16))),
            ));
          }
        },
        title: AppConstants.resetPassword,
        buttonHeight: 50,
        fontSize: 18,
      );
    });
  }
}

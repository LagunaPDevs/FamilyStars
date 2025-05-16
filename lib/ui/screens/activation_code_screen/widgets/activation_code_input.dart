import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/storage_constants.dart';
import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:familystars_2/infrastructure/services/firebase_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

// This widgets represents the fields where user can enter OTP received

class ActivationCodeInput extends StatefulWidget {
  const ActivationCodeInput({super.key});

  @override
  _ActivationCodeInputState createState() => _ActivationCodeInputState();
}

class _ActivationCodeInputState extends State<ActivationCodeInput> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final activationCodeProviderRef =
            ref.watch(activationCodeScreenProvider);
        final registrationScreenProviderRef =
            ref.watch(registrationScreenProvider);
        return Pinput(
          length: 6,
          controller: activationCodeProviderRef.pinPutController,
          focusNode: activationCodeProviderRef.pinPutFocusNode,
          defaultPinTheme: PinTheme(
            textStyle: TextStyle(
              color: ColorConstants.greyColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'KristenITC',
            ),
          ),
          submittedPinTheme: PinTheme(
            constraints: BoxConstraints(maxHeight: 70.h, maxWidth: 40.w),
            decoration: BoxDecoration(
              color: ColorConstants.yellowColor,
              border: Border.all(color: ColorConstants.greyColor, width: 1),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          focusedPinTheme: PinTheme(
            decoration: BoxDecoration(
              color: ColorConstants.whiteColor,
              border: Border.all(color: ColorConstants.greyColor, width: 1),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          followingPinTheme: PinTheme(
            decoration: BoxDecoration(
              color: ColorConstants.whiteColor,
              border: Border.all(color: ColorConstants.greyColor, width: 1),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          keyboardType: TextInputType.number,
          // mainAxisSize: MainAxisSize.max,
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          onChanged: (String pin) {
            activationCodeProviderRef.setVerificationCode(pin);
          },
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          ],
          // onSaved: (String? pin) {
          //   activationCodeProviderRef.setVerificationCode(pin!);
          // },
          onSubmitted: (String pin) async {
            String verificationID = StorageConstants.savedVerificationId;
            String verificationCode = '';
            activationCodeProviderRef.setVerificationCode(pin);
            verificationCode = activationCodeProviderRef.verificationCode;
            String email = registrationScreenProviderRef.emailController.text;
            String password =
                registrationScreenProviderRef.passwordController.text;

            // If the OTP introduced is correct, user can continue with registration
            bool registred =
                await FirebaseServices.registerUserWithFirebaseEmailCredentials(
                    context, verificationID, verificationCode, email, password);
            if (registred) {
              Navigator.of(context).pop();
            }
          },
          // withCursor: true,
        );
      },
    );
  }
}

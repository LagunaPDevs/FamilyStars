import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/storage_constants.dart';
import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:familystars_2/infrastructure/services/firebase_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pin_put/pin_put.dart';

// This widgets represents the fields where user can enter OTP received

class ActivationCodeInput extends StatefulWidget {
  const ActivationCodeInput({Key? key}) : super(key: key);

  @override
  _ActivationCodeInputState createState() => _ActivationCodeInputState();
}

class _ActivationCodeInputState extends State<ActivationCodeInput> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final activationCodeProviderRes = watch(activationCodeScreenProvider);
        return PinPut(
          controller: activationCodeProviderRes.pinPutController,
          focusNode: activationCodeProviderRes.pinPutFocusNode,
          fieldsCount: 6,
          keyboardType: TextInputType.number,
          mainAxisSize: MainAxisSize.max,
          eachFieldConstraints: BoxConstraints(maxHeight: 70.h, maxWidth: 40.w),
          onChanged: (String pin) {
            context.read(activationCodeScreenProvider).setVerificationCode(pin);
          },
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          ],
          onSaved: (String? pin) {
            context
                .read(activationCodeScreenProvider)
                .setVerificationCode(pin!);
          },
          onSubmit: (String pin) async {
            String verificationID = StorageConstants.savedVerificationId;
            String verificationCode = '';
            context.read(activationCodeScreenProvider).setVerificationCode(pin);
            verificationCode =
                context.read(activationCodeScreenProvider).verificationCode;
            String email =
                context.read(registrationScreenProvider).emailController.text;
            String password = context
                .read(registrationScreenProvider)
                .passwordController
                .text;

            // If the OTP introduced is correct, user can continue with registration
            bool registred =
                await FirebaseServices.registerUserWithFirebaseEmailCredentials(
                    context, verificationID, verificationCode, email, password);
            if (registred) {
              Navigator.of(context).pop();
            }
          },
          textStyle: TextStyle(
            color: ColorConstants.greyColor,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'KristenITC',
          ),
          withCursor: true,
          submittedFieldDecoration: BoxDecoration(
            color: ColorConstants.yellowColor,
            border: Border.all(color: ColorConstants.greyColor, width: 1),
            borderRadius: BorderRadius.circular(3),
          ),
          selectedFieldDecoration: BoxDecoration(
            color: ColorConstants.whiteColor,
            border: Border.all(color: ColorConstants.greyColor, width: 1),
            borderRadius: BorderRadius.circular(3),
          ),
          followingFieldDecoration: BoxDecoration(
            color: ColorConstants.whiteColor,
            border: Border.all(color: ColorConstants.greyColor, width: 1),
            borderRadius: BorderRadius.circular(3),
          ),
        );
      },
    );
  }
}

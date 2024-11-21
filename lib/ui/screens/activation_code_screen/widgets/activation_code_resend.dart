import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:familystars_2/infrastructure/services/firebase_services.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// This class provides a widget which provides the ability of resend a OTP code
// to email user

class ActivationCodeResend extends StatefulWidget {
  const ActivationCodeResend({Key? key}) : super(key: key);

  @override
  _ActivationCodeResendState createState() => _ActivationCodeResendState();
}

class _ActivationCodeResendState extends State<ActivationCodeResend> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final registrationProviderRes = ref.watch(registrationScreenProvider);
        return Column(
          children: [
            Text(
              AppConstants.verificationNotReceiveCode,
              style: TextStyle(color: ColorConstants.greyColor, fontSize: 14),
            ),
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {
                // Sends OTP again to the email
                CustomLoading.progressDialog(true, context);
                FirebaseServices.verifyUserEmailAccount(
                    context,
                    registrationProviderRes.emailController.text,
                    RoutesConstants.activationCodeScreen);
                CustomLoading.progressDialog(false, context);
              },
              child: Text(
                AppConstants.verificationResendCode,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorConstants.blueColor,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/ui/commons/logo_appbar.dart';
import 'package:familystars_2/ui/screens/activation_code_screen/widgets/activation_code_input.dart';
import 'package:familystars_2/ui/screens/activation_code_screen/widgets/activation_code_resend.dart';
import 'package:familystars_2/ui/screens/activation_code_screen/widgets/activation_code_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// This class represents a widget where user can enter the OTP received to
// it email account. If user haven't receive OTP it can be resend to in this
// screen

class ActivationCodeScreen extends StatelessWidget {
  const ActivationCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: LogoAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              ActivationCodeTitle(),
              SizedBox(
                height: LayoutConstants.generalVerticalSpace,
              ),
              ActivationCodeInput(),
              SizedBox(
                height: LayoutConstants.generalVerticalSpace,
              ),
              ActivationCodeResend(),
            ],
          ),
        ),
      ),
    );
  }
}

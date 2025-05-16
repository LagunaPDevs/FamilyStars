import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/ui/commons/logo_appbar.dart';
import 'package:familystars_2/ui/screens/choose_signup_method_screen/widgets/choose_signup_title.dart';
import 'package:familystars_2/ui/screens/choose_signup_method_screen/widgets/signup_email_button.dart';
import 'package:familystars_2/ui/screens/choose_signup_method_screen/widgets/signup_facebook_button.dart';
import 'package:familystars_2/ui/screens/choose_signup_method_screen/widgets/signup_google_button.dart';
import 'package:familystars_2/ui/screens/choose_signup_method_screen/widgets/signup_twitter_button.dart';
import 'package:familystars_2/ui/screens/have_account_screen/have_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// This widget shows the multiple ways that user can choose to register an
// account on app

class ChooseSignUpMethodScreen extends StatefulWidget {
  const ChooseSignUpMethodScreen({super.key});

  @override
  _ChooseSignUpMethodScreenState createState() =>
      _ChooseSignUpMethodScreenState();
}

class _ChooseSignUpMethodScreenState extends State<ChooseSignUpMethodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LogoAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(children: [
            ChooseSignUpTitle(),
            SizedBox(
              height: LayoutConstants.generalVerticalSpace,
            ),
            SignUpEmailButton(),
            SizedBox(
              height: LayoutConstants.generalItemSpace,
            ),
            SignUpFacebookButton(),
            SizedBox(
              height: LayoutConstants.generalItemSpace,
            ),
            SignUpGoogleButton(),
            SizedBox(
              height: LayoutConstants.generalItemSpace,
            ),
            SignUpTwitterButton(),
            SizedBox(
              height: LayoutConstants.generalVerticalSpace,
            ),
            Divider(
              height: 2,
              color: ColorConstants.blueColor,
            ),
            SizedBox(
              height: LayoutConstants.generalVerticalSpace,
            ),
            HaveAccountScreen(),
          ]),
        ),
      ),
    );
  }
}

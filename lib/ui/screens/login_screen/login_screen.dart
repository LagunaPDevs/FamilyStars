import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:familystars_2/ui/screens/dont_have_account_screen/dont_have_account_screen.dart';
import 'package:familystars_2/ui/screens/login_screen/widgets/login_button_screen.dart';
import 'package:familystars_2/ui/screens/login_screen/widgets/login_fields_screen.dart';
import 'package:familystars_2/ui/screens/login_screen/widgets/login_title_screen.dart';
import 'package:familystars_2/ui/screens/login_screen/widgets/social_media_button_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// This widget represents the screen where a registered user can be logged
// to the app

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoginTitleScreen(),
                    LoginFieldsScreen(),
                    SizedBox(
                      height: LayoutConstants.generalItemSpace,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RoutesConstants.forgotPasswordScreen);
                        },
                        child: Text(
                          AppConstants.forgotPassword,
                          style: TextStyle(
                              color: ColorConstants.blueColor, fontSize: 14),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: LayoutConstants.generalItemSpace,
                    ),
                    LoginButtonScreen(
                      formKey: _formKey,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 2.0,
                      color: ColorConstants.blueColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SocialMediaButtonScreen(),
                    SizedBox(
                      height: 20,
                    ),
                    DontHaveAccountScreen(),
                  ],
                ),
              ),
            )));
  }
}

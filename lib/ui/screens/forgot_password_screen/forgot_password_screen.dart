import 'dart:ui';

import 'package:familystars_2/ui/commons/logo_appbar.dart';
import 'package:familystars_2/ui/screens/forgot_password_screen/widgets/forgot_password_button.dart';
import 'package:familystars_2/ui/screens/forgot_password_screen/widgets/forgot_password_fields.dart';
import 'package:familystars_2/ui/screens/forgot_password_screen/widgets/forgot_password_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// This widget represent a screen where user can reset the password of account
// entering email

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LogoAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ForgotPasswordTitle(),
                ForgotPasswordFields(),
                ForgotPasswordButton(
                  formKey: _formKey,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
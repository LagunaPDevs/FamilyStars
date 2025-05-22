import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:familystars_2/ui/commons/text_widgets/common_text_form_field.dart';
import 'package:familystars_2/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// This widget contains the fields for email and password to be logged in
class LoginFieldsScreen extends StatefulWidget {
  const LoginFieldsScreen({super.key});

  @override
  _LoginFieldsScreenState createState() => _LoginFieldsScreenState();
}

class _LoginFieldsScreenState extends State<LoginFieldsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final logInProviderRes = ref.watch(logInScreenProvider);
      return Column(
        children: [
          CommonTextFormField(
            controller: logInProviderRes.emailController,
            focusNode: logInProviderRes.emailFocus,
            onChanged: (value) {},
            onFieldSubmitted: (value) {},
            validation: (value) {
              return Validators.validateEmail(context, value!);
            },
            inputFormatter: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9.+@]')),
              FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s")),
            ],
            hintText: AppConstants.emailHint,
            textInputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(
            height: LayoutConstants.generalVerticalSpace,
          ),
          CommonTextFormField(
            controller: logInProviderRes.passwordController,
            focusNode: logInProviderRes.passwordFocus,
            onChanged: (value) {},
            onFieldSubmitted: (value) {},
            validation: (value) {
              return Validators.validatePassword(context, value!);
            },
            suffixIcon: InkWell(
              onTap: () {
                logInProviderRes.setPasswordVisibility();
              },
              child: Icon(
                logInProviderRes.isVisiblePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey,
                size: 18.h,
              ),
            ),
            hintText: AppConstants.password,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.text,
            obscureText: logInProviderRes.isVisiblePassword ? false : true,
          )
        ],
      );
    });
  }
}

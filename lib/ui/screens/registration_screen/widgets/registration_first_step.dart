
import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/ui/commons/text_widgets/common_text_form_field.dart';
import 'package:familystars_2/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// This widget contains the first step needed to create an account in the app
// email and password.
// If user enter a email which is valid and it does not exists on the database
// the fields are validated
class RegistrationFirstStep extends StatefulWidget {
  const RegistrationFirstStep({super.key});

  @override
  _RegistrationFirstStepState createState() => _RegistrationFirstStepState();
}

class _RegistrationFirstStepState extends State<RegistrationFirstStep> {
  bool exists = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final registrationProviderRes = ref.watch(registrationScreenProvider);
      return Column(
        children: [
          CommonTextFormField(
            controller: registrationProviderRes.emailController,
            focusNode: registrationProviderRes.emailFocus,
            onChanged: (value) async {
              return Validators.validateEmail(context, value);
            },
            onFieldSubmitted: (value) async {
              return Validators.validateEmail(context, value);
            },
            validation: (value) {
              return Validators.validateEmail(context, value ?? "");
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
            controller: registrationProviderRes.passwordController,
            focusNode: registrationProviderRes.passwordFocus,
            onChanged: (value) {},
            onFieldSubmitted: (value) {},
            validation: (value) {
              return Validators.validatePassword(context, value!);
            },
            suffixIcon: InkWell(
              onTap: () {
                registrationProviderRes.setPasswordVisibility();
              },
              child: Icon(
                registrationProviderRes.isVisiblePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey,
                size: 18.h,
              ),
            ),
            hintText: AppConstants.password,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.text,
            obscureText:
                registrationProviderRes.isVisiblePassword ? false : true,
          )
        ],
      );
    });
  }
}
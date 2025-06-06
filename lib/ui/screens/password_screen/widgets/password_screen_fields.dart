import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/ui/commons/text_widgets/common_field_title.dart';
import 'package:familystars_2/ui/commons/text_widgets/common_text_form_field.dart';
import 'package:familystars_2/validators/validators.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';

class PasswordScreenFields extends StatefulWidget {
  const PasswordScreenFields({super.key});

  @override
  State<PasswordScreenFields> createState() => _PasswordScreenFieldsState();
}

class _PasswordScreenFieldsState extends State<PasswordScreenFields> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final passwordProviderRes = ref.watch(passwordScreenProvider);
      return Column(
        children: [
          CommonFieldTitle(title: AppConstants.password),
          SizedBox(
            height: LayoutConstants.generalVerticalSpace,
          ),
          // It is necesary to set a password
          CommonTextFormField(
            controller: passwordProviderRes.passwordController,
            focusNode: passwordProviderRes.passwordFocusNode,
            onChanged: (value) {
              return Validators.validatePassword(context, value!);
            },
            onFieldSubmitted: (value) {},
            validation: (value) {
              return Validators.validatePassword(context, value!);
            },
          ),
          // SizedBox(height: LayoutConstants.generalVerticalSpace,),
          // CommonFieldTitle(title: AppConstants.familiar),
          SizedBox(
            height: LayoutConstants.generalVerticalSpace,
          ),
          SizedBox(
            height: LayoutConstants.generalVerticalSpace,
          ),
        ],
      );
    });
  }
}

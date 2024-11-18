import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:familystars_2/ui/commons/text_widgets/common_text_form_field.dart';
import 'package:familystars_2/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Simple widget with a field to enter user email

class ForgotPasswordFields extends StatefulWidget {
  const ForgotPasswordFields({Key? key}) : super(key: key);

  @override
  _ForgotPasswordFieldsState createState() => _ForgotPasswordFieldsState();
}

class _ForgotPasswordFieldsState extends State<ForgotPasswordFields> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final forgotPasswordProviderRes =
          watch.read(forgotPasswordScreenProvider);
      return Column(
        children: [
          CommonTextFormField(
            controller: forgotPasswordProviderRes.emailController,
            focusNode: forgotPasswordProviderRes.emailFocus,
            onChanged: (value) {},
            onFieldSubmitted: (value) {},
            validation: (value) {
              return Validators.validateEmail(context, value!);
            },
            inputFormatter: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9.@]')),
              FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s")),
            ],
            hintText: AppConstants.emailHint,
            textInputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(
            height: LayoutConstants.generalVerticalSpace,
          ),
        ],
      );
    });
  }
}

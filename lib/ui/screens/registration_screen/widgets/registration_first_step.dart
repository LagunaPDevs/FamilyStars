import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:familystars_2/ui/commons/text_widgets/common_text_form_field.dart';
import 'package:familystars_2/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// This widget contains the first step needed to create an account in the app
// email and password.
// If user enter a email which is valid and it does not exists on the database
// the fields are validated
class RegistrationFirstStep extends StatefulWidget {
  const RegistrationFirstStep({Key? key}) : super(key: key);

  @override
  _RegistrationFirstStepState createState() => _RegistrationFirstStepState();
}

class _RegistrationFirstStepState extends State<RegistrationFirstStep> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  bool exists = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final registrationProviderRes = watch(registrationScreenProvider);
      return Column(
        children: [
          CommonTextFormField(
            controller: registrationProviderRes.emailController,
            focusNode: registrationProviderRes.emailFocus,
            onChanged: (value) async {
              await emailExists(value);
            },
            onFieldSubmitted: (value) async {
              await emailExists(value);
            },
            validation: (value) {
              return Validators.emailExists(context, value!, exists);
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
                context.read(logInScreenProvider).setPasswordVisibility();
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

  // Function that search on the database for the email introduced
  // If it is found, user could not be registered with the typed email

  Future<void> emailExists(String value) async {
    var document = await _firebaseFirestore
        .collection('users')
        .where("email_id", isEqualTo: value)
        .get();
    if (document.size > 0) {
      setState(() {
        exists = true;
      });
    } else {
      setState(() {
        exists = false;
      });
    }
  }
}

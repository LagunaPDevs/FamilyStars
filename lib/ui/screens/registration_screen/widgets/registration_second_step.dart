import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';

import 'package:familystars_2/ui/commons/text_widgets/common_field_title.dart';
import 'package:familystars_2/ui/commons/text_widgets/common_text_form_field.dart';
import 'package:familystars_2/ui/screens/registration_screen/widgets/registration_familiar_box.dart';

import 'package:familystars_2/validators/validators.dart';

// This widget represent a step on registration where user can set name and
// family type

class RegistrationSecondStep extends StatefulWidget {
  const RegistrationSecondStep({super.key});

  @override
  _RegistrationSecondStepState createState() => _RegistrationSecondStepState();
}

class _RegistrationSecondStepState extends State<RegistrationSecondStep> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final registrationProviderRes = ref.watch(registrationScreenProvider);

        return Column(
          children: [
            CommonTextFormField(
              controller: registrationProviderRes.fullnameController,
              focusNode: registrationProviderRes.fullnameFocus,
              onChanged: (value) {},
              onFieldSubmitted: (value) {},
              validation: (value) {
                return Validators.validateFullName(context, value!);
              },
              inputFormatter: [
                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
              ],
              hintText: AppConstants.fullname,
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: LayoutConstants.generalVerticalSpace,
            ),
            CommonFieldTitle(title: AppConstants.familiar),
            SizedBox(
              height: LayoutConstants.generalVerticalSpace,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RegistrationFamiliarBox(familiar: AppConstants.father),
                RegistrationFamiliarBox(familiar: AppConstants.mother),
                RegistrationFamiliarBox(familiar: AppConstants.other)
              ],
            ),
          ],
        );
      },
    );
  }
}

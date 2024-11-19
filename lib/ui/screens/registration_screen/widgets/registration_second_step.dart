import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:familystars_2/ui/commons/text_widgets/common_field_title.dart';
import 'package:familystars_2/ui/commons/text_widgets/common_text_form_field.dart';
import 'package:familystars_2/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This widget represent a step on registration where user can set name and
// family type

class RegistrationSecondStep extends StatefulWidget {
  const RegistrationSecondStep({Key? key}) : super(key: key);

  @override
  _RegistrationSecondStepState createState() => _RegistrationSecondStepState();
}

class _RegistrationSecondStepState extends State<RegistrationSecondStep> {
  bool selectedMother = true;
  bool selectedFather = false;
  bool selectedOther = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final registrationProviderRes = watch.read(registrationScreenProvider);

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
          // Select family type
          // ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    registrationProviderRes.familiarText = AppConstants.mother;
                    setState(() {
                      selectedMother = true;
                      selectedFather = false;
                      selectedOther = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: selectedMother
                            ? ColorConstants.yellowColor
                            : ColorConstants.blueColor),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        AppConstants.mother,
                        style: TextStyle(
                            color: ColorConstants.whiteColor, fontSize: 16),
                      ),
                    ),
                  )),
              GestureDetector(
                  onTap: () {
                    registrationProviderRes.familiarText = AppConstants.father;
                    setState(() {
                      selectedMother = false;
                      selectedFather = true;
                      selectedOther = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: selectedFather
                            ? ColorConstants.yellowColor
                            : ColorConstants.blueColor),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        AppConstants.father,
                        style: TextStyle(
                            color: ColorConstants.whiteColor, fontSize: 16),
                      ),
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  registrationProviderRes.familiarText = AppConstants.other;
                  setState(() {
                    selectedMother = false;
                    selectedFather = false;
                    selectedOther = true;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: selectedOther
                          ? ColorConstants.yellowColor
                          : ColorConstants.blueColor),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      AppConstants.other,
                      style: TextStyle(
                          color: ColorConstants.whiteColor, fontSize: 16),
                    ),
                  ),
                ),
              ),
              // ---
            ],
          ),
        ],
      );
    });
  }
}

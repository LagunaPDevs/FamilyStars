import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:familystars_2/ui/commons/logo_appbar.dart';
import 'package:familystars_2/ui/screens/registration_screen/widgets/registration_dob_step.dart';
import 'package:familystars_2/ui/screens/registration_screen/widgets/registration_done_button.dart';
import 'package:familystars_2/ui/screens/registration_screen/widgets/registration_first_step.dart';
import 'package:familystars_2/ui/screens/registration_screen/widgets/registration_next_button.dart';
import 'package:familystars_2/ui/screens/registration_screen/widgets/registration_previous_button.dart';
import 'package:familystars_2/ui/screens/registration_screen/widgets/registration_second_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_stepper/stepper.dart';

// This screen hold all user registration process

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final registrationProviderRes = watch(registrationScreenProvider);
      int activeStep = registrationProviderRes.activeStep;
      int upperBound = registrationProviderRes.upperBound;
      bool isFinish = activeStep == upperBound;
      return Scaffold(
          appBar: const LogoAppBar(),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                const SizedBox(
                  height: LayoutConstants.generalVerticalSpace,
                ),
                // Set a stepper to manage registration
                // ---
                NumberStepper(
                  numbers: const [1, 2, 3],
                  numberStyle: const TextStyle(
                      color: ColorConstants.whiteColor,
                      fontFamily: 'KristenITC'),
                  activeStep: registrationProviderRes.activeStep,
                  onStepReached: (index) {
                    setState(() {
                      registrationProviderRes.activeStep = index;
                    });
                  },
                  stepColor: ColorConstants.blueColor,
                  activeStepColor: ColorConstants.yellowColor,
                  lineColor: ColorConstants.blueColor,
                ),
                // ---
                const SizedBox(
                  height: LayoutConstants.generalVerticalSpace,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Form(
                      key: _formKey,
                      child: Center(child: registrationFields(activeStep))),
                ),
                const SizedBox(
                  height: LayoutConstants.generalVerticalSpace,
                ),
                // Set step buttons
                // ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RegistrationPreviousButton(
                      formKey: _formKey,
                    ),
                    isFinish
                        ? RegistrationDoneButton(
                            formKey: _formKey,
                          )
                        : RegistrationNextButton(
                            formKey: _formKey,
                          )
                  ],
                )
                // ---
              ],
            ),
          ));
    });
  }

  Widget registrationFields(int activeStep) {
    switch (activeStep) {
      case 0:
        return const RegistrationFirstStep();
      case 1:
        return const RegistrationSecondStep();
      case 2:
        return const RegistrationDobStep();
      default:
        return const RegistrationFirstStep();
    }
  }
}

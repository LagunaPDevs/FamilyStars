import 'package:flutter/material.dart';

import 'package:familystars_2/ui/screens/create_user_screen/widgets/familiar_child_card_button.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';

// This widget permits to select the type of child user
// It can be 'Niña', 'Niño' or 'Otro'
// The type selected is shown in yellow collor

class CreateUserChildSelect extends StatelessWidget {
  const CreateUserChildSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FamiliarChildCardButton(familiar: AppConstants.ninia),
        SizedBox(
          width: LayoutConstants.generalItemSpace,
        ),
        FamiliarChildCardButton(familiar: AppConstants.ninio),
        SizedBox(
          width: LayoutConstants.generalItemSpace,
        ),
        FamiliarChildCardButton(familiar: AppConstants.other)
      ],
    );
  }
}

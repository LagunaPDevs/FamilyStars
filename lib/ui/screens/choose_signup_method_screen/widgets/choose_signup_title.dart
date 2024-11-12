import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';

import 'package:familystars_2/ui/commons/text_widgets/title_text.dart';
import 'package:flutter/material.dart';

// Simple widget that shows title for 'ChooseSignUpMethodScreen'

class ChooseSignUpTitle extends StatelessWidget {
  const ChooseSignUpTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: LayoutConstants.verticalTopSpace,
            ),
            TitleText(title: AppConstants.chooseSignUp),
            SizedBox(
              height: LayoutConstants.generalVerticalSpace,
            ),
          ],
        ),
      ),
    );
  }
}

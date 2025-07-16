import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/ui/commons/button_widgets/pink_gradient_button.dart';

// This widget represents a button that leads to 'CalendarScreen'

class CalendarButton extends StatelessWidget {
  const CalendarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final parentMainScreenProviderRef = ref.watch(parentMainScreenProvider);
        return PinkGradientButton(
          title: AppConstants.calendar,
          onTap: () => parentMainScreenProviderRef.openCalendarScreen(context),
        );
      },
    );
  }
}

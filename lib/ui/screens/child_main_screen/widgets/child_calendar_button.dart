import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/ui/commons/button_widgets/pink_gradient_button.dart';

// This widget represents a button that leads to 'ChildCalendarScreen'

class ChildCalendarButton extends StatelessWidget {
  final String userPath;
  const ChildCalendarButton({super.key, required this.userPath});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final childMainScreenProviderRef = ref.watch(childMainScreenProvider);
        return PinkGradientButton(
          onTap: () => childMainScreenProviderRef
              .openChildCalendarScreen(context, userPath: userPath),
          title: AppConstants.calendar,
        );
      },
    );
  }
}

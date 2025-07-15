import 'package:flutter/material.dart';

import 'package:familystars_2/infrastructure/constants/color_constants.dart';

class PinkGradientCard extends StatelessWidget {
  final Widget child;
  const PinkGradientCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        height: 300,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorConstants.pinkGradient.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(5),
        ),
        child: child);
  }
}

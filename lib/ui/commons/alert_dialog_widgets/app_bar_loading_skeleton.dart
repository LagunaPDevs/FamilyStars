import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class AppBarLoadingSkeleton extends StatelessWidget {
  const AppBarLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Shimmer(
          child: SizedBox(
            width: 80,
            height: 80,
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer(
              child: SizedBox(
                width: 100,
                height: 25,
              ),
            ),
            Shimmer(
              child: SizedBox(
                width: 80,
                height: 25,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

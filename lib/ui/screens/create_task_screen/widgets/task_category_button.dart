import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';

class TaskCategoryButton extends StatelessWidget {
  final String category;
  final String iconPath;
  const TaskCategoryButton(
      {super.key, required this.category, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final createTaskScreenRef = ref.watch(createTaskScreenProvider);
      return GestureDetector(
          onTap: () => createTaskScreenRef.setCategory(category),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _boxColor(createTaskScreenRef.categoryText == category),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Image.asset(
              iconPath,
              width: 30,
              height: 30,
            ),
          ));
    });
  }
}

Color _boxColor(bool isSelected) {
  return isSelected ? ColorConstants.yellowColor : ColorConstants.whiteColor;
}

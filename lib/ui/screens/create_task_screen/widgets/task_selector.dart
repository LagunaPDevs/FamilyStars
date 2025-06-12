import 'package:flutter/material.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/image_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/ui/screens/create_task_screen/widgets/task_category_button.dart';

class TaskSelector extends StatelessWidget {
  const TaskSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TaskCategoryButton(
            category: AppConstants.homeCategory,
            iconPath: ImageConstants.homeIcon),
        const SizedBox(
          width: LayoutConstants.generalItemSpace,
        ),
        TaskCategoryButton(
            category: AppConstants.schoolCategory,
            iconPath: ImageConstants.schoolIcon),
        const SizedBox(
          width: LayoutConstants.generalItemSpace,
        ),
        TaskCategoryButton(
            category: AppConstants.groceryCategory,
            iconPath: ImageConstants.groceryIcon),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';

import 'package:familystars_2/ui/commons/text_widgets/common_field_title.dart';

import 'package:familystars_2/ui/screens/create_task_screen/widgets/task_date_selector.dart';
import 'package:familystars_2/ui/screens/create_task_screen/widgets/task_selector.dart';
import 'package:familystars_2/ui/screens/create_task_screen/widgets/dropdown_tasks.dart';
import 'package:familystars_2/ui/screens/create_task_screen/widgets/gridview_child_users.dart';
import 'package:familystars_2/ui/screens/create_task_screen/widgets/stars_button.dart';

// This widget contains all necesary fields to create a new task

class CreateTaskFields extends StatefulWidget {
  const CreateTaskFields({super.key});

  @override
  _CreateTaskFieldsState createState() => _CreateTaskFieldsState();
}

class _CreateTaskFieldsState extends State<CreateTaskFields> {
  String dropdownbutton = AppConstants.selectTask;
  String dropdownchild = AppConstants.selectChild;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final createTaskProviderRes = ref.watch(createTaskScreenProvider);
        return Column(
          children: [
            const SizedBox(
              height: LayoutConstants.generalVerticalSpace,
            ),
            TaskSelector(),
            const SizedBox(
              height: LayoutConstants.generalVerticalSpace,
            ),
            Text(
              createTaskProviderRes.nameText,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: LayoutConstants.generalVerticalSpace,
            ),
            const DropDownTasks(),
            const SizedBox(
              height: LayoutConstants.generalVerticalSpace,
            ),
            TaskDateSelector(),
            const SizedBox(
              height: LayoutConstants.generalVerticalSpace,
            ),
            Row(
              children: [
                const CommonFieldTitle(title: AppConstants.assignTo),
                const SizedBox(
                  width: 50,
                ),
                Text(
                  createTaskProviderRes.assignedName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: LayoutConstants.generalVerticalSpace,
            ),
            const GridViewChildUsers(),
            const SizedBox(
              height: LayoutConstants.generalVerticalSpace,
            ),
            const StarsButton(),
          ],
        );
      },
    );
  }
}
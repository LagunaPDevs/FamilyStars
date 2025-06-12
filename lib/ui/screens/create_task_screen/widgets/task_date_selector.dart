import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';

import 'package:familystars_2/ui/commons/button_widgets/custom_button.dart';
import 'package:familystars_2/ui/commons/text_widgets/common_field_title.dart';

class TaskDateSelector extends StatelessWidget {
  const TaskDateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final createTaskScreenRef = ref.watch(createTaskScreenProvider);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const CommonFieldTitle(title: AppConstants.selectDate),
          const SizedBox(
            width: LayoutConstants.generalVerticalSpace,
          ),
          Text(
            createTaskScreenRef.dateText,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          CustomButton(
            title: AppConstants.changeDate,
            onPressed: () async {
              await _selectDate(context,
                  selected: DateTime.tryParse(createTaskScreenRef.dateText) ??
                      DateTime.now(),
                  setDate: (date) => createTaskScreenRef.setDateText(date));
            },
            fontSize: 18,
          ),
        ],
      );
    });
  }
}

Future<void> _selectDate(BuildContext context,
    {required DateTime selected, required Function(DateTime) setDate}) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selected,
      firstDate: selected,
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: ColorConstants.whiteColor,
            colorScheme:
                const ColorScheme.light(secondary: ColorConstants.blueColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      });
  if (picked != null && picked != selected) {
    setDate(picked);
  }
}

import 'dart:ui';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/image_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:familystars_2/ui/commons/button_widgets/custom_button.dart';
import 'package:familystars_2/ui/commons/text_widgets/common_field_title.dart';
import 'package:familystars_2/ui/screens/create_task_screen/widgets/dropdown_tasks.dart';
import 'package:familystars_2/ui/screens/create_task_screen/widgets/gridview_child_users.dart';
import 'package:familystars_2/ui/screens/create_task_screen/widgets/stars_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

// This widget contains all necesary fields to create a new task

class CreateTaskFields extends StatefulWidget {
  const CreateTaskFields({Key? key}) : super(key: key);

  @override
  _CreateTaskFieldsState createState() => _CreateTaskFieldsState();
}

class _CreateTaskFieldsState extends State<CreateTaskFields> {
  String dropdownbutton = AppConstants.selectTask;
  String dropdownchild = AppConstants.selectChild;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        DateTime defaultTime = DateTime.now();
        final createTaskProviderRes = watch(createTaskScreenProvider);
        createTaskProviderRes.dateText =
            '${defaultTime.day}/${defaultTime.month}/${defaultTime.year}';
        DateTime now = DateTime.now();
        return Column(
          children: [
            SizedBox(
              height: LayoutConstants.generalVerticalSpace,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Select task category, it sets the different task available
                // --- Starts here

                GestureDetector(
                    onTap: () {
                      createTaskProviderRes.setHome();
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: createTaskProviderRes.isHome
                            ? ColorConstants.yellowColor
                            : ColorConstants.whiteColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Image.asset(
                        ImageConstants.homeIcon,
                        width: 30,
                        height: 30,
                      ),
                    )),
                SizedBox(
                  width: LayoutConstants.generalItemSpace,
                ),
                GestureDetector(
                    onTap: () {
                      createTaskProviderRes.setSchool();
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: createTaskProviderRes.isSchool
                            ? ColorConstants.yellowColor
                            : ColorConstants.whiteColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Image.asset(
                        ImageConstants.schoolIcon,
                        width: 30,
                        height: 30,
                      ),
                    )),
                SizedBox(
                  width: LayoutConstants.generalItemSpace,
                ),
                GestureDetector(
                    onTap: () {
                      createTaskProviderRes.setGrocery();
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: createTaskProviderRes.isGrocery
                            ? ColorConstants.yellowColor
                            : ColorConstants.whiteColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Image.asset(
                        ImageConstants.groceryIcon,
                        width: 30,
                        height: 30,
                      ),
                    )),

                // --- End here
              ],
            ),
            SizedBox(
              height: LayoutConstants.generalVerticalSpace,
            ),
            Text(
              createTaskProviderRes.nameText,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: LayoutConstants.generalVerticalSpace,
            ),
            DropDownTasks(),
            SizedBox(
              height: LayoutConstants.generalVerticalSpace,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Select date functionality
                // --- Stars here
                CommonFieldTitle(title: AppConstants.selectDate),
                SizedBox(
                  width: LayoutConstants.generalVerticalSpace,
                ),
                Text(
                  '${selectedDate.toLocal()}'.split(' ')[0],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                CustomButton(
                  title: AppConstants.changeDate,
                  onPressed: () async {
                    await _selectDate(context);
                    String completeDate = 'selectedDate.toLocal()'.split('')[0];
                    List splittedDate = completeDate.split('-');
                    try {
                      createTaskProviderRes.setDateText(
                          '${splittedDate[2]}/${splittedDate[1]}/${splittedDate[0]}');
                    } catch (e) {}
                    //createTaskProviderRes.dateText = '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
                  },
                  fontSize: 18,
                ),
                // --- Ends here
              ],
            ),
            SizedBox(
              height: LayoutConstants.generalVerticalSpace,
            ),
            Row(
              children: [
                CommonFieldTitle(title: AppConstants.assignTo),
                SizedBox(
                  width: 50,
                ),
                Text(
                  createTaskProviderRes.assignedName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: LayoutConstants.generalVerticalSpace,
            ),
            GridViewChildUsers(),
            SizedBox(
              height: LayoutConstants.generalVerticalSpace,
            ),
            StarsButton(),
          ],
        );
      },
    );
  }

  // This function retrieve a pop up calendar where user can show a date

  Future<void> _selectDate(BuildContext context) async {
    DateTime today = DateTime.now();

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: today,
        firstDate: today,
        lastDate: DateTime(2050),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: ColorConstants.whiteColor,
              accentColor: ColorConstants.blueColor,
              colorScheme: ColorScheme.light(primary: ColorConstants.blueColor),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        });
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
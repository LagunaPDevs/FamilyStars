import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Widget that shows on a list the different task available depending
// on category

class DropDownTasks extends StatefulWidget {
  const DropDownTasks({super.key});

  @override
  _DropDownTasksState createState() => _DropDownTasksState();
}

class _DropDownTasksState extends State<DropDownTasks> {
  String dropdownbutton = AppConstants.selectTask;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final createTaskProviderRes = ref.watch(createTaskScreenProvider);
      String category = createTaskProviderRes.categoryText;

      // This method retrieves a list of task
      List<String> dropdownList(String category) {
        switch (category) {
          case 'Hogar':
            dropdownbutton = AppConstants.selectTask;
            return createTaskProviderRes.homeTasks;
          case 'Escolar':
            dropdownbutton = AppConstants.selectTask;
            return createTaskProviderRes.schoolTasks;
          case 'Compras':
            dropdownbutton = AppConstants.selectTask;
            return createTaskProviderRes.groceryTasks;
          default:
            return createTaskProviderRes.homeTasks;
        }
      }

      return Stack(
        alignment: Alignment.bottomRight,
        children: [
          Icon(
            Icons.height,
            color: ColorConstants.yellowColor,
            size: 120,
          ),
          Container(
            height: 125,
            decoration: BoxDecoration(
              border: Border.all(color: ColorConstants.yellowColor),
              borderRadius: BorderRadius.circular(10),
              color: ColorConstants.yellowColor.withValues(alpha: 0.3),
            ),
            child: ListView.builder(
                itemCount: dropdownList(category).length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(dropdownList(category)[index],
                            style: TextStyle(
                                color: ColorConstants.greyColor,
                                fontFamily: 'KristenITC')),
                        onTap: () {
                          createTaskProviderRes
                              .setName(dropdownList(category)[index]);
                        },
                      ),
                      Divider(height: 1, color: ColorConstants.yellowColor)
                    ],
                  );
                }),
          ),
        ],
      );
    });
  }
}

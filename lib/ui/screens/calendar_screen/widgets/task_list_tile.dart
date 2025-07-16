import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';

import 'package:familystars_2/ui/screens/calendar_screen/widgets/uncompleted_task_card_tile.dart';

// This class holds a widget that retrieve the list of task assigned to all
// children owned by an specific parent user in CalendarScreen

class TasksListTile extends StatelessWidget {
  const TasksListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final parentCalendarProviderRef =
            ref.watch(parentCalendarScreenProvider);
        return StreamBuilder(
          stream: parentCalendarProviderRef.buildParentUserTaskList(
              isNotState: AppConstants.completed
              ),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                      color: ColorConstants.blueColor));
            }
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(8),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                final task = snapshot.data[index];
                if (task.state == AppConstants.completed) {
                  return null;
                }
                return UncompletedTaskCardTile(task: task);
              },
            );
          },
        );
      },
    );
  }
}

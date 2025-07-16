import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';

import 'package:familystars_2/ui/screens/calendar_child_screen/widgets/uncompleted_task_card_tile.dart';

// This class holds a widget that retrieve the list of task assigned to a child
// user in ChildCalendarScreen

class ChildTaskListTile extends StatelessWidget {
  final String userPath;
  const ChildTaskListTile({super.key, required this.userPath});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final childCalendarProviderRef = ref.watch(childCalendarScreenProvider);
        return StreamBuilder(
          stream: childCalendarProviderRef.buildUserTaskList(
              userId: userPath, 
              isNotState: AppConstants.completed
              ),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator(
                      color: ColorConstants.blueColor));
            }
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
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

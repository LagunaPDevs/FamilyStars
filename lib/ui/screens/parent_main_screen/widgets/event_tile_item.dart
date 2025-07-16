import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/infrastructure/models/event.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_change_state_dialog.dart';

class EventTileItem extends StatelessWidget {
  final TaskEvent event;
  const EventTileItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final parentMainScreenProviderRef = ref.watch(parentMainScreenProvider);
      return GestureDetector(
        onTap: () async {
          // If task state is 'En espera'
          // It change not only the task state, also create an event
          // Otherwise user would be warned that nothing can be done

          // A parent user has the ability of complete task. If a task is
          // 'Completa' the child user attached to it receive the appropriate stars

          if (event.taskState == AppConstants.waiting) {
            CustomChangeStateDialog(
              onOkTap: () async {
                final result = await parentMainScreenProviderRef
                    .handleTaskFromEventComplete(event: event);
                if (result && context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor:
                          ColorConstants.purpleGradient.withValues(alpha: .5),
                      content: SizedBox(
                        height: 100,
                        child: Text(
                          AppConstants.completedTask,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  );
                }
              },
              title: 'Cambiar estado de tarea',
              content:
                  '¿Quiere cambiar el estado de la tarea de \'${event.assignedName}\'?',
              context: context,
            ).show();
          }
          if (event.taskState == AppConstants.incomplete) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor:
                    ColorConstants.purpleGradient.withValues(alpha: .5),
                content: SizedBox(
                  height: 100,
                  child: Text(
                    AppConstants.waitingChild,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            );
          }
          if (event.taskState == AppConstants.completed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor:
                    ColorConstants.purpleGradient.withValues(alpha: .5),
                content: SizedBox(
                  height: 100,
                  child: Text(
                    AppConstants.completedTask,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            );
          }
        },

        // The information shows on the panel will depend on task state

        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(event.date ?? '',
                  style: TextStyle(color: ColorConstants.purpleGradient)),
              SizedBox(
                height: LayoutConstants.generalVerticalSpace,
              ),
              event.taskState == AppConstants.completed
                  ? Text(
                      'Tarea \'${event.taskName}\' de \'${event.assignedName}\' completada.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16, color: ColorConstants.greenColor),
                    )
                  : event.taskState == AppConstants.waiting
                      ? Text(
                          'Revisar \'${event.taskName}\' de \'${event.assignedName}\'',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, color: ColorConstants.yellowColor))
                      : Text(
                          'Se ha asignado \'${event.taskName}\' a \'${event.assignedName}\'',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, color: ColorConstants.blueColor)),
              SizedBox(
                height: LayoutConstants.generalVerticalSpace,
              ),
              Divider(
                height: 1,
                color: ColorConstants.purpleGradient,
              ),
              SizedBox(
                height: LayoutConstants.generalItemSpace,
              ),
            ],
          ),
        ),
      );
    });
  }
}

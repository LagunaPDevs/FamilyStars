import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/infrastructure/models/event.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_change_state_dialog.dart';

class ChildEventTileItem extends StatelessWidget {
  final TaskEvent event;
  const ChildEventTileItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final childMainScreenProviderRef = ref.watch(childMainScreenProvider);
        return GestureDetector(
          onTap: () async {
            if (event.taskState == AppConstants.waiting) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor:
                    ColorConstants.purpleGradient.withValues(alpha: .5),
                content: const SizedBox(
                    height: 100,
                    child: Text(AppConstants.waitingParent,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16))),
              ));
            }
            if (event.taskState == AppConstants.incomplete) {
              CustomChangeStateDialog(
                onOkTap: () async {
                  final result = await childMainScreenProviderRef
                      .handleTaskFromEventComplete(event: event);
                  if (result && context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor:
                            ColorConstants.purpleGradient.withValues(alpha: .5),
                        content: const SizedBox(
                            height: 100,
                            child: Text(AppConstants.waitingTask,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16))),
                      ),
                    );
                  }
                },
                title: 'Cambiar estado de tarea',
                content: '¿Quieres cambiar el estado de la tarea?',
                context: context,
              ).show();
            }
            if (event.taskState == AppConstants.completed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor:
                      ColorConstants.purpleGradient.withValues(alpha: .5),
                  content: const SizedBox(
                    height: 100,
                    child: Text(
                      AppConstants.completedTask,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              );
            }
          },

          // The information shown on the panel will depend on task state

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
                        '¡Has completado la tarea \'${event.taskName}\'!¡¡Ganaste ${event.taskStars} estrellas!!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, color: ColorConstants.greenColor),
                      )
                    : event.taskState == AppConstants.incomplete
                        ? Text(
                            'Se te ha asignado \'${event.taskName}\' por un valor de ${event.taskStars} estrellas.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16, color: ColorConstants.blueColor))
                        : Text(
                            'La tarea \'${event.taskName}\' está a la espera de ser revisada.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: ColorConstants.yellowColor)),
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
      },
    );
  }
}

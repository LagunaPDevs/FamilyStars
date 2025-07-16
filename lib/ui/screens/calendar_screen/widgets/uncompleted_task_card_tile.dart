import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/infrastructure/models/task.dart';

import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_change_state_dialog.dart';

class UncompletedTaskCardTile extends StatefulWidget {
  final Task task;
  const UncompletedTaskCardTile({super.key, required this.task});

  @override
  State<UncompletedTaskCardTile> createState() =>
      _UncompletedTaskCardTileState();
}

class _UncompletedTaskCardTileState extends State<UncompletedTaskCardTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final parentCalendarProviderRef =
            ref.watch(parentCalendarScreenProvider);
        return Container(
          decoration: BoxDecoration(
              color: ColorConstants.whiteColor,
              border: Border.all(color: _boxColor(widget.task.state)),
              borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(bottom: 4),
          child: GestureDetector(
            onTap: () {
              // If task state is 'En espera'
              // It change not only the task state, also create an event
              // Otherwise user would be warned that nothing can be done
              if (widget.task.state == AppConstants.waiting) {
                CustomChangeStateDialog(
                  onOkTap: () async {
                      setState(() {
                        widget.task.state = AppConstants.completed;
                      });
                    final result = await parentCalendarProviderRef
                        .handleTaskComplete(task: widget.task);
                    // context is not mounted ??
                    if (result && context.mounted) Navigator.pop(context);
                    
                  },
                  title: 'Cambiar estado de tarea',
                  content:
                      '¿Quiere cambiar el estado de la tarea de \'${widget.task.assignedName}\'?',
                  context: context,
                ).show();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor:
                        ColorConstants.purpleGradient.withValues(alpha: .5),
                    content: SizedBox(
                      height: 100,
                      child: Text(
                        AppConstants.waitingChild,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                );
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('${widget.task.name} (${widget.task.assignedName})'),
                Text(
                  widget.task.state ?? '',
                  style: TextStyle(
                      color: _boxColor(widget.task.state),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Color _boxColor(String? state) {
  if (state == AppConstants.incomplete) return ColorConstants.redColor;
  return ColorConstants.yellowColor;
}

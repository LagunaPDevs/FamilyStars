import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_change_state_dialog.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  final String taskName;
  final String userName;
  final String state;
  final Function() onOkTap;
  const TaskCard(
      {super.key,
      required this.userName,
      required this.state,
      required this.onOkTap,
      required this.taskName});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ClipRRect(
            child: Container(
      decoration: BoxDecoration(
          color: ColorConstants.whiteColor,
          border: Border.all(color: ColorConstants.redColor)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(widget.taskName),
              GestureDetector(
                  onTap: () {
                    CustomChangeStateDialog(
                      onOkTap: () {
                        widget.onOkTap;
                      },
                      title: 'Cambiar estado de tarea',
                      content:
                          '¿Quiere cambiar el estado de la tarea de \'${widget.userName}\'?',
                      context: context,
                    ).show();
                  },
                  child: Text(
                    widget.state,
                    style: TextStyle(
                        color: ColorConstants.redColor,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ]),
      ),
    )));
  }
}

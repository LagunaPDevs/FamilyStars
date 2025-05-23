import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/services/firebase_services.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_change_state_dialog.dart';
import 'package:flutter/material.dart';

// This class holds a widget that retrieve the list of task assigned to a child
// user in ChildCalendarScreen

class ChildTaskListTile extends StatefulWidget {
  final String userPath;
  const ChildTaskListTile({super.key, required this.userPath});

  @override
  _ChildTaskListTileState createState() => _ChildTaskListTileState();
}

class _ChildTaskListTileState extends State<ChildTaskListTile> {
  // Build of the task items
  Widget _buildListOfIncompleteTasks(
      BuildContext context, DocumentSnapshot document) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference childRef = firestore.collection('users');
    CollectionReference taskRef = firestore.collection('tasks');

    // Depending on value the widget will be painted in different ways
    bool isIncomplete = document['state'] == AppConstants.incomplete;
    bool isCompleted = document['state'] == AppConstants.completed;

    // If task is 'Completa' it retrieves nothing, other way it returns a item
    // with task information

    return isCompleted
        ? const SizedBox(
            width: 10,
          )
        : Card(
            child: ClipRRect(
                child: GestureDetector(
            onTap: () async {
              DateTime today = DateTime.now();
              String onlyDate = today.toLocal().toString().split(' ')[0];
              List splittedDate = onlyDate.split('-');
              String todayDate =
                  '${splittedDate[2]}/${splittedDate[1]}/${splittedDate[0]}';

              // If task state is 'Incompleta'
              // It change not only the task state, also create an event
              // Otherwise user would be warned that nothing can be done
              if (document['state'] == AppConstants.incomplete) {
                CustomChangeStateDialog(
                  onOkTap: () async {
                    await taskRef
                        .doc(document.id)
                        .update({'state': 'En espera'});
                    await FirebaseServices.creteNewEvent(
                        todayDate,
                        document['owner'],
                        document['assigned'],
                        document['assigned_name'],
                        document.id,
                        document['name'],
                        AppConstants.waiting,
                        document['stars']);
                    Navigator.pop(context);
                  },
                  title: 'Cambiar estado de tarea',
                  content: '¿Quieres cambiar el estado de la tarea?',
                  context: context,
                ).show();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor:
                      ColorConstants.purpleGradient.withOpacity(0.5),
                  content: const SizedBox(
                      height: 100,
                      child: Text(AppConstants.waitingParent,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16))),
                ));
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  color: ColorConstants.whiteColor,
                  border: Border.all(
                      color: isIncomplete
                          ? ColorConstants.redColor
                          : ColorConstants.yellowColor),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                          '${document['name']} (${AppConstants.stars}: ${document['stars']})'),
                      Text(
                        document['state'],
                        style: TextStyle(
                            color: isIncomplete
                                ? ColorConstants.redColor
                                : ColorConstants.yellowColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          )));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .where('assigned', isEqualTo: widget.userPath)
            .where('state', isNotEqualTo: 'Completa')
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child:
                    CircularProgressIndicator(color: ColorConstants.blueColor));
          }
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) =>
                _buildListOfIncompleteTasks(context, snapshot.data.docs[index]),
          );
        });
  }
}

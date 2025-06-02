import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/services/firebase_services.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_change_state_dialog.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// This class holds a widget that retrieve the list of task assigned to all
// children owned by an specific parent user in CalendarScreen

class TasksListTile extends StatefulWidget {
  const TasksListTile({super.key});

  @override
  _TasksListTileState createState() => _TasksListTileState();
}

class _TasksListTileState extends State<TasksListTile> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Build of the task items
  Widget _buildListOfIncompleteTasks(
      BuildContext context, DocumentSnapshot document) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference childRef = firestore.collection('users');
    CollectionReference taskRef = firestore.collection('tasks');

    String name = document['assigned_name'];
    String stars = '0';

    // Depending on value the widget will be painted in different ways
    bool isIncomplete = document['state'] == AppConstants.incomplete;
    bool isCompleted = document['state'] == AppConstants.completed;

    DateTime today = DateTime.now();
    String onlyDate = today.toLocal().toString().split(' ')[0];
    List splittedDate = onlyDate.split('-');
    String todayDate =
        '${splittedDate[2]}/${splittedDate[1]}/${splittedDate[0]}';

    return Card(
        child: ClipRRect(
            child: GestureDetector(
      onTap: () async {
        await childRef
            .doc(document['assigned'])
            .get()
            .then((value) => stars = value['stars']);

        int taskStars = int.parse(document['stars']);
        int addStars = int.parse(stars) + taskStars;
        String total = addStars.toString();

        // If task state is 'En espera'
        // It change not only the task state, also create an event
        // Otherwise user would be warned that nothing can be done
        if (document['state'] == 'En espera') {
          CustomChangeStateDialog(
            onOkTap: () async {
              CustomLoading.progressDialog(true, context);

              await childRef
                  .doc(document['assigned'])
                  .update({'stars': total});
              await taskRef.doc(document.id).update({'state': 'Completa'});
              await FirebaseServices.createNewEvent(
                  todayDate,
                  document['owner'],
                  document['assigned'],
                  document['assigned_name'],
                  document.id,
                  document['name'],
                  AppConstants.completed,
                  document['stars']);

              CustomLoading.progressDialog(false, context);

              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: ColorConstants.purpleGradient.withOpacity(0.5),
                content: SizedBox(
                    height: 100,
                    child: Text(AppConstants.completedTask,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16))),
              ));
            },
            title: 'Cambiar estado de tarea',
            content: '¿Quiere cambiar el estado de la tarea de \'$name\'?',
            context: context,
          ).show();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: ColorConstants.purpleGradient.withOpacity(0.5),
            content: SizedBox(
                height: 100,
                child: Text(AppConstants.waitingChild,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
          ));
        }
      },
      child: !isCompleted
          ? Container(
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
                          '${document['name']} (${document['assigned_name']})'),
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
            )
          : SizedBox(
              width: 10,
            ),
    )));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .where('owner', isEqualTo: _firebaseAuth.currentUser!.uid)
            .where('state', isNotEqualTo: 'Completa')
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child:
                    CircularProgressIndicator(color: ColorConstants.blueColor));
          }
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.all(8),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) =>
                _buildListOfIncompleteTasks(context, snapshot.data.docs[index]),
          );
        });
  }
}

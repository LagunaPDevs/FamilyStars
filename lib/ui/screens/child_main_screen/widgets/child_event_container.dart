import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/infrastructure/services/firebase_services.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_change_state_dialog.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// This widget shows a container with all the events related to an specific
// child user
// As well as 'ChildCalendarScreen' a child user can change task state using
// this container

class ChildEventContainer extends StatefulWidget {
  final String userPath;
  const ChildEventContainer({Key? key, required this.userPath})
      : super(key: key);

  @override
  _ChildEventContainerState createState() => _ChildEventContainerState();
}

class _ChildEventContainerState extends State<ChildEventContainer> {
  // Build the list of events for a child
  Widget _buildListOfEvents(BuildContext context, DocumentSnapshot document) {
    FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference _taskData = _firebaseFirestore.collection('tasks');
    bool completa = document['task_state'] == AppConstants.completed;
    bool espera = document['task_state'] == AppConstants.waiting;
    bool incompleta = document['task_state'] == AppConstants.incomplete;

    DateTime today = DateTime.now();
    String onlyDate = today.toLocal().toString().split(' ')[0];
    List splittedDate = onlyDate.split('-');
    String todayDate =
        '${splittedDate[2]}/${splittedDate[1]}/${splittedDate[0]}';

    // If task state is 'Incompleta'
    // It change not only the task state, also create an event
    // Otherwise user would be warned that nothing can be done

    return GestureDetector(
      onTap: () async {
        if (document['task_state'] == AppConstants.waiting) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: ColorConstants.purpleGradient.withOpacity(0.5),
            content: Container(
                height: 100,
                child: Text(AppConstants.waitingParent,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
          ));
        }
        if (document['task_state'] == AppConstants.incomplete) {
          CustomChangeStateDialog(
            onOkTap: () async {
              CustomLoading.progressDialog(true, context);

              // Change task state
              await _taskData
                  .doc(document['task_id'])
                  .update({'state': AppConstants.waiting});
              // Create an event
              await FirebaseServices.creteNewEvent(
                  todayDate,
                  document['owner'],
                  document['assigned'],
                  document['assigned_name'],
                  document['task_id'],
                  document['task_name'],
                  AppConstants.waiting,
                  document['task_stars']);

              CustomLoading.progressDialog(false, context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: ColorConstants.purpleGradient.withOpacity(0.5),
                content: Container(
                    height: 100,
                    child: Text(AppConstants.waitingTask,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16))),
              ));
              Navigator.pop(context);
            },
            title: 'Cambiar estado de tarea',
            content: '¿Quieres cambiar el estado de la tarea?',
            context: context,
          ).show();
        }
        if (document['task_state'] == AppConstants.completed) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: ColorConstants.purpleGradient.withOpacity(0.5),
            content: Container(
                height: 100,
                child: Text(AppConstants.completedTask,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
          ));
        }
      },

      // The information shown on the panel will depend on task state

      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(document['date'],
                style: TextStyle(color: ColorConstants.purpleGradient)),
            SizedBox(
              height: LayoutConstants.generalVerticalSpace,
            ),
            completa
                ? Text(
                    '¡Has completado la tarea \'${document['task_name']}\'!¡¡Ganaste ${document['task_stars']} estrellas!!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )
                : incompleta
                    ? Text(
                        'Se te ha asignado \'${document['task_name']}\' por un valor de ${document['task_stars']} estrellas.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16))
                    : Text(
                        'La tarea \'${document['task_name']}\' está a la espera de ser revisada.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16)),
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        height: 300,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: ColorConstants.pinkGradient.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5)),
        child: ListView(
          children: [
            Text(
              AppConstants.eventList,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            // only a total of 10 are shown order by creation descending
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('event')
                    .orderBy('created', descending: true)
                    .limit(10)
                    .where('assigned', isEqualTo: widget.userPath)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                        child: CircularProgressIndicator(
                            color: ColorConstants.blueColor));
                  // build list of items
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(8),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) =>
                        _buildListOfEvents(context, snapshot.data.docs[index]),
                  );
                }),
          ],
        ));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/infrastructure/services/firebase_services.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_change_state_dialog.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// This widget shows a container with all the events related to an specific
// parent user.
// This events are related with the task it assign to multiple child user and
// also the changes in task state
// As well as 'CalendarScreen' a parent user can change task state using this
// container

class ParentEventContainer extends StatefulWidget {
  const ParentEventContainer({super.key});

  @override
  _ParentEventContainerState createState() => _ParentEventContainerState();
}

class _ParentEventContainerState extends State<ParentEventContainer> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Build the list of events related to a parent user
  Widget _buildListOfEvents(BuildContext context, DocumentSnapshot document) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference taskData = firebaseFirestore.collection('tasks');
    CollectionReference childData = firebaseFirestore.collection('users');
    bool completa = document['task_state'] == AppConstants.completed;
    bool espera = document['task_state'] == AppConstants.waiting;

    DateTime today = DateTime.now();
    String onlyDate = today.toLocal().toString().split(' ')[0];
    List splittedDate = onlyDate.split('-');
    String todayDate =
        '${splittedDate[2]}/${splittedDate[1]}/${splittedDate[0]}';

    String stars = '0';

    return GestureDetector(
      onTap: () async {
        // If task state is 'En espera'
        // It change not only the task state, also create an event
        // Otherwise user would be warned that nothing can be done

        // A parent user has the ability of complete task. If a task is
        // 'Completa' the child user attached to it receive the appropriate stars

        if (document['task_state'] == AppConstants.waiting) {
          await childData
              .doc(document['assigned'])
              .get()
              .then((value) => stars = value['stars']);

          int taskStars = int.parse(document['task_stars']);
          int addStars = int.parse(stars) + taskStars;
          String total = addStars.toString();

          CustomChangeStateDialog(
            onOkTap: () async {
              CustomLoading.progressDialog(true, context);
              // Change task state
              await taskData
                  .doc(document['task_id'])
                  .update({'state': AppConstants.completed});
              // Set child stars
              await childData
                  .doc(document['assigned'])
                  .update({'stars': total});
              // Create an event
              await FirebaseServices.creteNewEvent(
                  todayDate,
                  document['owner'],
                  document['assigned'],
                  document['assigned_name'],
                  document['task_id'],
                  document['task_name'],
                  AppConstants.completed,
                  document['task_stars']);

              CustomLoading.progressDialog(false, context);

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: ColorConstants.purpleGradient.withOpacity(0.5),
                content: SizedBox(
                    height: 100,
                    child: Text(AppConstants.completedTask,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16))),
              ));

              Navigator.pop(context);
            },
            title: 'Cambiar estado de tarea',
            content:
                '¿Quiere cambiar el estado de la tarea de \'${document['assigned_name']}\'?',
            context: context,
          ).show();
        }
        if (document['task_state'] == AppConstants.incomplete) {
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
        if (document['task_state'] == AppConstants.completed) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: ColorConstants.purpleGradient.withOpacity(0.5),
            content: SizedBox(
                height: 100,
                child: Text(AppConstants.completedTask,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
          ));
        }
      },

      // The information shows on the panel will depend on task state

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
                    'Tarea \'${document['task_name']}\' de \'${document['assigned_name']}\' completada.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorConstants.greenColor
                    ),
                  )
                : espera
                    ? Text(
                        'Revisar \'${document['task_name']}\' de \'${document['assigned_name']}\'',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: ColorConstants.yellowColor))
                    : Text(
                        'Se ha asignado \'${document['task_name']}\' a \'${document['assigned_name']}\'',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: ColorConstants.blueColor)),
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
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('event')
                    .orderBy('created', descending: true)
                    .limit(10)
                    .where('owner', isEqualTo: _firebaseAuth.currentUser?.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator(
                            color: ColorConstants.blueColor));
                  } else {
                    Text(
                      AppConstants.noData,
                      textAlign: TextAlign.center,
                    );
                  }
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

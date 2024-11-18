import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:familystars_2/infrastructure/services/firebase_services.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This widget has de functionality to assign a new task to a child by a parent

class CreateTaskButton extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  const CreateTaskButton({Key? key, this.formKey}) : super(key: key);

  @override
  _CreateTaskButtonState createState() => _CreateTaskButtonState();
}

class _CreateTaskButtonState extends State<CreateTaskButton> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final createTaskProviderRes = watch.read(createTaskScreenProvider);
      return SizedBox(
        width: 80,
        height: 80,
        child: FloatingActionButton(
            backgroundColor: ColorConstants.blueColor,
            onPressed: () async {
              // If every field is completed the task is assigned

              if (widget.formKey!.currentState!.validate()) {
                String owner = _firebaseAuth.currentUser!.uid;
                String assigned = createTaskProviderRes.assignedText;
                String assignedName = createTaskProviderRes.assignedName;
                String name = createTaskProviderRes.nameText;
                String category = createTaskProviderRes.categoryText;
                String date = createTaskProviderRes.dateText;
                String stars = createTaskProviderRes.starsText;
                if (assigned.isNotEmpty &&
                        name.isNotEmpty &&
                        stars.isNotEmpty ||
                    stars != '0') {
                  CustomLoading.progressDialog(true, context);
                  bool created = await FirebaseServices.addNewTaskToChild(owner,
                      assigned, assignedName, name, category, date, stars);
                  if (created) {
                    CustomLoading.progressDialog(false, context);
                    createTaskProviderRes.cleanFields();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor:
                          ColorConstants.purpleGradient.withOpacity(0.5),
                      content: SizedBox(
                          height: 100,
                          child: Text(AppConstants.taskCreated,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16))),
                    ));
                    //Navigator.popAndPushNamed(context, RoutesConstants.createTaskScreen);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor:
                        ColorConstants.purpleGradient.withOpacity(0.5),
                    content: SizedBox(
                        height: 100,
                        child: Text(AppConstants.incompleteFields,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                  ));
                }
              }
            },
            child: Text('+',
                style:
                    TextStyle(color: ColorConstants.whiteColor, fontSize: 25))),
      );
    });
  }
}

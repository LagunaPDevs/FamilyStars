import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:familystars_2/infrastructure/services/firebase_services.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This widget creates a new child user

class CreateUserButtons extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  const CreateUserButtons({Key? key, this.formKey}) : super(key: key);

  @override
  _CreateUserButtonsState createState() => _CreateUserButtonsState();
}

class _CreateUserButtonsState extends State<CreateUserButtons> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final createUserProviderRes = watch(createUserScreenProvider);
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 80,
                height: 80,
                child: FloatingActionButton(
                  heroTag: 'clean',
                  backgroundColor: ColorConstants.blueColor,
                  onPressed: () {
                    createUserProviderRes.cleanFields();
                  },
                  child: Icon(Icons.cleaning_services,
                      color: ColorConstants.whiteColor),
                ),
              ),
              SizedBox(
                width: LayoutConstants.generalItemSpace,
              ),
              Container(
                width: 80,
                height: 80,
                child: FloatingActionButton(
                  heroTag: 'add',
                  backgroundColor: ColorConstants.blueColor,
                  onPressed: () async {
                    String name = createUserProviderRes.userNameController.text;
                    String familiar = createUserProviderRes.familiarText;
                    String dob = createUserProviderRes.dobText;

                    // If all fields are validated the child user is created
                    if (widget.formKey!.currentState!.validate()) {
                      bool isCreated =
                          await FirebaseServices.addChildUserToFirestore(
                              context, name, familiar, dob);
                      if (isCreated) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor:
                              ColorConstants.purpleGradient.withOpacity(0.5),
                          content: Container(
                              height: 100,
                              child: Text(AppConstants.userCreated,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))),
                        ));
                        CustomLoading.progressDialog(true, context);
                        CustomLoading.progressDialog(false, context);
                        createUserProviderRes.cleanFields();
                      }
                    }
                  },
                  child: Text('+',
                      style: TextStyle(
                          color: ColorConstants.whiteColor, fontSize: 25)),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}

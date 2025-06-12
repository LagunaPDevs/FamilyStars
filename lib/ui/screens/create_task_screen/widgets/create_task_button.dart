import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';


// This widget has de functionality to assign a new task to a child by a parent

class CreateTaskButton extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  const CreateTaskButton({super.key, this.formKey});

  @override
  _CreateTaskButtonState createState() => _CreateTaskButtonState();
}

class _CreateTaskButtonState extends State<CreateTaskButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final createTaskProviderRes = ref.watch(createTaskScreenProvider);
        return SizedBox(
          width: 80,
          height: 80,
          child: FloatingActionButton(
              backgroundColor: ColorConstants.blueColor,
              onPressed: () async {
                if (widget.formKey!.currentState!.validate()) {
                  final created =
                      await createTaskProviderRes.addNewTaskToChild();
                  if (created && context.mounted) {
                    _succesfulScaffold(context);
                  }
                } else {
                  _errorScaffold(context);
                }
              },
              child: Text('+',
                  style: TextStyle(
                      color: ColorConstants.whiteColor, fontSize: 25))),
        );
      },
    );
  }
}

_succesfulScaffold(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: ColorConstants.purpleGradient.withValues(alpha: .5),
    content: SizedBox(
        height: 100,
        child: Text(AppConstants.taskCreated,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
  ));
}

_errorScaffold(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: ColorConstants.purpleGradient.withValues(alpha: 0.5),
    content: SizedBox(
        height: 100,
        child: Text(AppConstants.incompleteFields,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
  ));
}

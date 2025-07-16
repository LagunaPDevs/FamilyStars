import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';

// This widget creates a new child user

class CreateUserButtons extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  const CreateUserButtons({super.key, this.formKey});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final createUserProviderRes = ref.watch(createUserScreenProvider);
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: FloatingActionButton(
                    heroTag: 'clean',
                    backgroundColor: ColorConstants.blueColor,
                    onPressed: () => createUserProviderRes.cleanFields(),
                    child: Icon(Icons.cleaning_services,
                        color: ColorConstants.whiteColor),
                  ),
                ),
                SizedBox(
                  width: LayoutConstants.generalItemSpace,
                ),
                SizedBox(
                  width: 80,
                  height: 80,
                  child: FloatingActionButton(
                    heroTag: 'add',
                    backgroundColor: ColorConstants.blueColor,
                    onPressed: () async {
                      // If all fields are validated the child user is created
                      String validateForm = createUserProviderRes
                          .validateForm(formKey!.currentState!.validate());
                      if (validateForm.isEmpty) {
                        bool isCreated =
                            await createUserProviderRes.createNewUser();
                        if (isCreated && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: ColorConstants.purpleGradient
                                .withValues(alpha: .5),
                            content: SizedBox(
                                height: 100,
                                child: Text(AppConstants.userCreated,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))),
                          ));
                          createUserProviderRes.cleanFields();
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: ColorConstants.purpleGradient
                                .withValues(alpha: .5),
                            content: SizedBox(
                              height: 100,
                              child: Text(
                                validateForm,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    child: Icon(Icons.add, color: ColorConstants.whiteColor) ,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

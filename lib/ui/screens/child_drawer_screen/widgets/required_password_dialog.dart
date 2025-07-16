import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';

class RequiredPasswordDialog extends StatelessWidget {
  const RequiredPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final childDrawerProviderRef = ref.watch(childDrawerScreenProvider);
        return AlertDialog(
          title: const Center(
              child: Text(AppConstants.changeUser,
                  style: TextStyle(color: ColorConstants.blueColor))),
          content: SizedBox(
            child: TextField(
              enabled: childDrawerProviderRef.isLoading == false,
              controller: childDrawerProviderRef.passwordController,
              focusNode: childDrawerProviderRef.passwordFocus,
              obscureText: true,
              style: TextStyle(
                  fontSize: 16,
                  color: ColorConstants.blueColor,
                  fontFamily: "KristenITC"),
              decoration: const InputDecoration(
                hintText: AppConstants.password,
                focusColor: ColorConstants.greyColor,
                hintStyle: TextStyle(color: ColorConstants.greyColor),
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            GestureDetector(
              onTap: () => childDrawerProviderRef.isLoading
                  ? null
                  : childDrawerProviderRef.handleOnOkClick(context),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: ColorConstants.blueColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  AppConstants.ok,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.greenColor),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () => childDrawerProviderRef.isLoading
                  ? null
                  : Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  AppConstants.cancel,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            childDrawerProviderRef.isLoading
                ? CircularProgressIndicator()
                : SizedBox()
          ],
        );
      },
    );
  }
}

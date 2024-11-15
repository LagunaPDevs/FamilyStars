import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This widget permits to select the type of child user
// It can be 'Niña', 'Niño' or 'Otro'
// The type selected is shown in yellow collor

class CreateUserChildSelect extends StatefulWidget {
  const CreateUserChildSelect({Key? key}) : super(key: key);

  @override
  _CreateUserChildSelectState createState() => _CreateUserChildSelectState();
}

class _CreateUserChildSelectState extends State<CreateUserChildSelect> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final createUserProviderRes = watch(createUserScreenProvider);
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                createUserProviderRes.setNinia();
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: createUserProviderRes.isNinia
                        ? ColorConstants.yellowColor
                        : ColorConstants.blueColor),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    AppConstants.ninia,
                    style: TextStyle(
                        color: ColorConstants.whiteColor, fontSize: 18),
                  ),
                ),
              )),
          SizedBox(
            width: LayoutConstants.generalItemSpace,
          ),
          GestureDetector(
              onTap: () {
                createUserProviderRes.setNinio();
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: createUserProviderRes.isNinio
                        ? ColorConstants.yellowColor
                        : ColorConstants.blueColor),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    AppConstants.ninio,
                    style: TextStyle(
                        color: ColorConstants.whiteColor, fontSize: 18),
                  ),
                ),
              )),
          SizedBox(
            width: LayoutConstants.generalItemSpace,
          ),
          GestureDetector(
            onTap: () {
              createUserProviderRes.setOther();
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: createUserProviderRes.isOther
                      ? ColorConstants.yellowColor
                      : ColorConstants.blueColor),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  AppConstants.other,
                  style:
                      TextStyle(color: ColorConstants.whiteColor, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

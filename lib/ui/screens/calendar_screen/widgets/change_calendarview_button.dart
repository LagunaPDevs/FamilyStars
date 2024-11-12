import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

// This widget have the ability of change the view of calendar
// Works both for parent and child

class ChangeCalendarViewButton extends StatefulWidget {
  const ChangeCalendarViewButton({Key? key}) : super(key: key);

  @override
  _ChangeCalendarViewButtonState createState() =>
      _ChangeCalendarViewButtonState();
}

class _ChangeCalendarViewButtonState extends State<ChangeCalendarViewButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final calendarProviderRes = watch(calendarScreenProvider);
      bool month = calendarProviderRes.monthView;
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  onTap: () {
                    calendarProviderRes.setMonthView(true);
                  },
                  child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: month
                              ? ColorConstants.yellowColor
                              : ColorConstants.greyColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        AppConstants.monthView,
                        style: TextStyle(
                            color: ColorConstants.whiteColor, fontSize: 16),
                      ))),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      calendarProviderRes.setMonthView(false);
                    });
                  },
                  child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: month
                              ? ColorConstants.greyColor
                              : ColorConstants.yellowColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        AppConstants.weekView,
                        style: TextStyle(
                            color: ColorConstants.whiteColor, fontSize: 16),
                      )))
            ],
          ),
        ],
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';

// This widget have the ability of change the view of calendar
// Works both for parent and child

class CalendarViewButton extends StatelessWidget {
  final CalendarView selectedView;
  final Function(CalendarView) onViewChange;

  const CalendarViewButton(
      {super.key, required this.onViewChange, required this.selectedView});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
                onTap: () {
                  onViewChange(CalendarView.month);
                },
                child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: selectedView == CalendarView.month
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
                onViewChange(CalendarView.week);
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: selectedView == CalendarView.week
                        ? ColorConstants.yellowColor
                        : ColorConstants.greyColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  AppConstants.weekView,
                  style:
                      TextStyle(color: ColorConstants.whiteColor, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

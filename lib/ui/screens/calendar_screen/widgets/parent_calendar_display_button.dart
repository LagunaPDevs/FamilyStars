import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/ui/commons/button_widgets/calendar_view_button.dart';

// This widget have the ability of change the view of calendar
// Works both for parent and child

class ParentCalendarDisplayButton extends StatelessWidget {
  const ParentCalendarDisplayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final parentCalendarProviderRef =
            ref.watch(parentCalendarScreenProvider);
        return CalendarViewButton(
            onViewChange: (view) =>
                parentCalendarProviderRef.setCalendarView(view),
            selectedView: parentCalendarProviderRef.calendarView);
      },
    );
  }
}

import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/ui/commons/button_widgets/calendar_view_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChildCalendarDisplayButton extends StatelessWidget {
  const ChildCalendarDisplayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final childCalendarProvider = ref.watch(childCalendarScreenProvider);
        return CalendarViewButton(
            onViewChange: (view) => childCalendarProvider.setCalendarView(view),
            selectedView: childCalendarProvider.calendarView);
      },
    );
  }
}

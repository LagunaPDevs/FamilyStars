import 'package:familystars_2/infrastructure/models/task.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// Helper class to create an Appointment in SfCalendar
class TaskCalendarSource extends CalendarDataSource {
  List<Task> listTask = [];

  TaskCalendarSource(List<Appointment> source) {
    appointments = source;
  }
}

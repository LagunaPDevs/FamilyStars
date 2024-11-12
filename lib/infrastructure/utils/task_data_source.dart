import 'package:familystars_2/infrastructure/models/task.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// Helper class to create an Appointment in SfCalendar
class TaskDataSource extends CalendarDataSource {
  List<Task> listTask = [];

  TaskDataSource(List<Appointment> source) {
    appointments = source;
  }
}

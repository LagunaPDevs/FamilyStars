// This class represents a event related to a task
// Mostly detects state changes

import 'package:familystars_2/infrastructure/models/task.dart';
import 'package:familystars_2/infrastructure/utils/date_utils.dart';

class TaskEvent {
  String? id;
  String? created;
  String? date;
  String? owner;
  String? assigned;
  String? assignedName;
  String? taskId;
  String? taskName;
  String? taskState;
  String? taskStars;

  TaskEvent(
      {this.id,
      this.created,
      this.date,
      this.owner,
      this.assigned,
      this.assignedName,
      this.taskId,
      this.taskName,
      this.taskState,
      this.taskStars});

  factory TaskEvent.fromNoData() => TaskEvent();

  factory TaskEvent.fromJson(Map<String, dynamic> json) => TaskEvent(
      id: json["id"],
      date: json["date"],
      created: json["created"],
      owner: json["owner"],
      assigned: json["assigned"],
      assignedName: json["assigned_name"],
      taskId: json["task_id"],
      taskName: json["task_name"],
      taskState: json["task_state"],
      taskStars: json["task_stars"]);

  factory TaskEvent.fromTask(Task task) => TaskEvent(
      date: task.date,
      created: dateToDDMMYY(DateTime.now()),
      owner: task.owner,
      assigned: task.assigned,
      assignedName: task.assigned,
      taskName: task.name,
      taskState: "Incompleta",
      taskStars: task.stars,
    ); 

  Map<String, dynamic> toJson() => {
        "date": date,
        "created": created,
        "owner": owner,
        "asigned": assigned,
        "assigned_name": assignedName,
        "task_id": taskId,
        "task_name": taskName,
        "task_state": taskState,
        "task_stars": taskStars
      };
}

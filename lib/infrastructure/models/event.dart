// This class represents a event related to a task
// Mostly detects state changes

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

  Map<String, dynamic> toJson(String? owner) => {
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

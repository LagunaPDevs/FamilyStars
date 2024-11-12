// This class represents a event related to a task
// Mostly detects state changes

class TaskEvent {
  String? id;
  String? created;
  String? date;
  String? owner;
  String? assigned;
  String? assigned_name;
  String? task_id;
  String? task_name;
  String? task_state;
  String? task_stars;

  TaskEvent({this.id,
    this.created,
    this.date,
    this.owner,
    this.assigned,
    this.assigned_name,
    this.task_id,
    this.task_name,
    this.task_state,
    this.task_stars
  });
}
import 'package:cloud_firestore/cloud_firestore.dart';

/// This class represents a task which is a assigned to a child user by a
/// parent user

class Task {
  String? id;
  String? created;
  String? name;
  String? assigned;
  String? assignedName;
  String? category;
  String? startTime;
  String? date;
  String? endTime;
  String? owner;
  String? stars;
  String? state;

  Task(
      {this.id,
      this.created,
      this.name,
      this.assigned,
      this.assignedName,
      this.category,
      this.startTime,
      this.date,
      this.endTime,
      this.owner,
      this.stars,
      this.state});

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        name: json['name'],
        assigned: json['asigned'],
        category: json['category'],
        date: json['date'],
        owner: json['owner'],
        stars: json['stars'],
        state: json['state'],
      );

  Map<String, dynamic> toJson() => {
        'created': Timestamp.fromDate(DateTime.now()),
        'owner': owner,
        'assigned': assigned,
        'assigned_name': assignedName,
        'name': name,
        'category': category,
        'date': date,
        'stars': stars,
        'state': 'Incompleta'
      };
}

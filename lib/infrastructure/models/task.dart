import 'package:cloud_firestore/cloud_firestore.dart';

// This class represents a task which is a assigned to a child user by a
// parent user

class Task{
  String? id;
  String? created;
  String? name;
  String? assigned;
  String? assigned_name;
  String? category;
  String? startTime;
  String? date;
  String? endTime;
  String? owner;
  String? stars;
  String? state;

  Task({
    this.id,
    this.created,
    this.name,
    this.assigned,
    this.assigned_name,
    this.category,
    this.startTime,
    this.date,
    this.endTime,
    this.owner,
    this.stars,
    this.state
  });

  factory Task.fromDoc(DocumentSnapshot doc){
    return Task(
      id: doc.id,
      name: doc.get('name'),
      assigned: doc.get('asigned'),
      category: doc.get('category'),
      date: doc.get('date'),
      owner: doc.get('owner'),
      stars: doc.get('stars'),
      state: doc.get('state'),
    );
  }
}
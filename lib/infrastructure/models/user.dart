import 'dart:core';

/// This class defines all users

class UserModel{
  String? id;
  String? name;
  String? parent;
  String? familiar;
  String? password;
  String? email;
  String? dob;
  String? stars;
  List<String>? tasks;

  UserModel({
    this.id,
    this.name,
    this.parent,
    this.familiar,
    this.password,
    this.email,
    this.dob,
    this.stars,
    this.tasks
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    parent: json["parent"],
    password: json["password"],
    email: json["email"],
    dob: json["date_of_birt"],
    stars: json["stars"],
    tasks: List.from(json["tasks"])
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "familiar": familiar,
    "parent": parent,
    "date_of_birth": dob,
    "stars": stars,
    "tasks": tasks
  };
}

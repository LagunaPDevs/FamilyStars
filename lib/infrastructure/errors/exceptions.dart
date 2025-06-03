class TaskEventException implements Exception {
  final String message;

  TaskEventException({required this.message});
}

class TaskException implements Exception {
  final String message;
  TaskException({required this.message});
}

class UserException implements Exception {
  final String message;

  UserException({required this.message});
}
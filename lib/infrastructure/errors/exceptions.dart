class TaskEventException implements Exception {
  final String message;

  TaskEventException({required this.message});
}

class TaskException implements Exception {
  final String message;
  TaskException({required this.message});
}

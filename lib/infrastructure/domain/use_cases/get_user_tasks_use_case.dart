import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familystars_2/infrastructure/domain/repositories/task_repository.dart';

class GetUserTasksUseCase {
  final TaskRepository taskRepository;

  GetUserTasksUseCase({required this.taskRepository});

  Stream<QuerySnapshot<Map<String, dynamic>>>? getUserTasksUseCase({required String userId, String? state}){
    return taskRepository.getUserTasks(userId: userId, state: state);
  }
}
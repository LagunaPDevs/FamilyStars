import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:familystars_2/infrastructure/domain/repositories/task_event_repository.dart';

class GetUserEventListUseCase {
  final TaskEventRepository taskEventRepository;

  GetUserEventListUseCase({required this.taskEventRepository});

  Stream<QuerySnapshot<Map<String, dynamic>>>? getUserEventList(String userId,
      {int? limit}) {
    return taskEventRepository.getUserEventList(userId);
  }
}

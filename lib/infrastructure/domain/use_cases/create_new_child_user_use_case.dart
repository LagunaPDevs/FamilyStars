import 'package:firebase_auth/firebase_auth.dart';

import 'package:familystars_2/infrastructure/domain/repositories/user_repository.dart';
import 'package:familystars_2/infrastructure/errors/result.dart';
import 'package:familystars_2/infrastructure/models/user.dart';

class CreateNewChildUserUseCase {
  final UserRepository userRepository;
  final FirebaseAuth firebaseAuth;

  CreateNewChildUserUseCase(
      {required this.firebaseAuth, required this.userRepository});

  Future<bool> createNewChildUser(UserModel user) async {
    final result = await userRepository.createNewChildUser(user);
    switch (result) {
      case Ok():
        final childId = result.result;
        final addIdResult = await _addIdToChild(id: childId, user: user);
        return addIdResult;
      case Error():
        return false;
    }
  }

  Future<bool> _addIdToChild(
      {required String? id, required UserModel user}) async {
    final parentId = firebaseAuth.currentUser?.uid;
    if (id == null || parentId == null) return false;

    user.id = id;
    user.parent = parentId;

    final updateUserResult = await userRepository.updateCurrentUser(user);
    switch (updateUserResult) {
      case Ok():
        return updateUserResult.result;
      case Error():
        return false;
    }
  }
}

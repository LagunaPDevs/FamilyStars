import 'package:familystars_2/infrastructure/errors/result.dart';
import 'package:familystars_2/infrastructure/models/user.dart';

abstract class UserRepository {
  Future<Result<bool>> assignTaskToUser(
      {required String userId, required String taskId});
  Future<Result<String?>> createNewChildUser(UserModel child);
  Future<Result<UserModel?>> getUserById(String userId);
  Future<Result<bool>> updateCurrentUser(UserModel user);
  Future<Result<List<UserModel>>> getParentUserChildren(String parentId);
}

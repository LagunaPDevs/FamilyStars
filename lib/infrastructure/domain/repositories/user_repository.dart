import 'package:familystars_2/infrastructure/data_sources/user_data_source.dart';
import 'package:familystars_2/infrastructure/errors/exceptions.dart';
import 'package:familystars_2/infrastructure/models/user.dart';

abstract class UserRepository {
  Future<bool> assignTaskToUser(
      {required String userId, required String taskId});
  Future<String?> createNewChildUser(UserModel child);
  Future<UserModel?> getUserById(String userId);
  Future<bool> updateCurrentUser(UserModel user);
  Future<List<UserModel>> getParentUserChildren(String parentId);
}

class UserRepositoryImpl implements UserRepository {
  final UserDataSource dataSource;

  UserRepositoryImpl({required this.dataSource});

  @override
  Future<bool> assignTaskToUser(
      {required String userId, required String taskId}) async {
    try {
      final result =
          await dataSource.assignTaskToUser(userId: userId, taskId: taskId);
      return result;
    } on UserException catch (_) {
      return false;
    }
  }

  @override
  Future<String?> createNewChildUser(UserModel child) async {
    try {
      final result = await dataSource.createNewChildUser(child);
      return result;
    } on UserException catch (_) {
      return null;
    }
  }

  @override
  Future<List<UserModel>> getParentUserChildren(String parentId) async {
    try {
      final result = await dataSource.getParentUserChildren(parentId);
      return result;
    } on UserException catch (_) {
      return [];
    }
  }

  @override
  Future<UserModel?> getUserById(String userId) async {
    try {
      final result = await dataSource.getUserById(userId);
      return result;
    } on UserException catch (_) {
      return null;
    }
  }

  @override
  Future<bool> updateCurrentUser(UserModel user) async {
    try {
      final result = await dataSource.updateCurrentUser(user);
      return result;
    } on UserException catch (_) {
      return false;
    }
  }
}

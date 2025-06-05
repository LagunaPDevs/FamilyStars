import 'package:familystars_2/infrastructure/data_sources/user_data_source.dart';
import 'package:familystars_2/infrastructure/errors/exceptions.dart';
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

class UserRepositoryImpl implements UserRepository {
  final UserDataSource dataSource;

  UserRepositoryImpl({required this.dataSource});

  @override
  Future<Result<bool>> assignTaskToUser(
      {required String userId, required String taskId}) async {
    try {
      final result =
          await dataSource.assignTaskToUser(userId: userId, taskId: taskId);
      return Result.ok(result);
    } on UserException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<String?>> createNewChildUser(UserModel child) async {
    try {
      final result = await dataSource.createNewChildUser(child);
      return Result.ok(result);
    } on UserException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<List<UserModel>>> getParentUserChildren(String parentId) async {
    try {
      final result = await dataSource.getParentUserChildren(parentId);
      return Result.ok(result);
    } on UserException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<UserModel?>> getUserById(String userId) async {
    try {
      final result = await dataSource.getUserById(userId);
      return Result.ok(result);
    } on UserException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<bool>> updateCurrentUser(UserModel user) async {
    try {
      final result = await dataSource.updateCurrentUser(user);
      return Result.ok(result);
    } on UserException catch (e) {
      return Result.error(e);
    }
  }
}

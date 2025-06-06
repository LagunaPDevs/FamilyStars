import 'package:familystars_2/infrastructure/constants/error_constants.dart';
import 'package:familystars_2/infrastructure/errors/exceptions.dart';
import 'package:familystars_2/infrastructure/models/user.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

abstract class UserDataSource {
  Future<bool> assignTaskToUser(
      {required String userId, required String taskId});
  Future<String?> createNewChildUser(UserModel child);
  Future<List<UserModel>> getParentUserChildren(String parentId);
  Future<UserModel> getUserById(String userId);
  Future<bool> updateCurrentUser(UserModel user);
}

class UserDataSourceImpl extends UserDataSource {
  final FirebaseCrashlytics firebaseCrashlytics;
  final FirebaseFirestore firebaseFirestore;

  UserDataSourceImpl({
      required this.firebaseCrashlytics,
      required this.firebaseFirestore});

  @override
  Future<bool> assignTaskToUser(
      {required String userId, required String taskId}) async {
    try {
      final result = await firebaseFirestore
          .collection("users")
          .doc(userId)
          .update({
            "tasks": FieldValue.arrayUnion([taskId])
          })
          .then((_) => true)
          .onError((e, stack) {
            firebaseCrashlytics.recordError(e, stack);
            throw TaskException(message: "Error adding task to user $userId");
          });
      return result;
    } catch (e, stack) {
      firebaseCrashlytics.recordError(e, stack);
      throw UserException(message: ErrorConstants.unhandled);
    }
  }

  @override
  Future<String?> createNewChildUser(UserModel child) async {
    try {
      final result = await firebaseFirestore
          .collection('users')
          .add(child.toJson())
          .then((value) => value.id);
      return result;
    } catch (e, stack) {
      firebaseCrashlytics.recordError(e, stack);
      throw UserException(message: ErrorConstants.unhandled);
    }
  }

  @override
  Future<List<UserModel>> getParentUserChildren(String parentId) async {
    try {
      final result = await firebaseFirestore
          .collection("users")
          .where('parent', isEqualTo: parentId)
          .get()
          .then((values) => values.docs.map((value) {
                return UserModel.fromJson(value.data());
              }).toList())
          .onError((e, stack) {
        firebaseCrashlytics.recordError(e, stack);
        throw UserException(message: "Error getting $parentId children users");
      });
      return result;
    } catch (e, stack) {
      firebaseCrashlytics.recordError(e, stack);
      throw UserException(message: ErrorConstants.unhandled);
    }
  }

  @override
  Future<UserModel> getUserById(String userId) async {
    try {
      final result = await firebaseFirestore
          .collection("users")
          .doc(userId)
          .get()
          .then((value) {
        if (value.data() != null) {
          return UserModel.fromJson(value.data()!);
        } else {
          throw UserException(message: "User do not exist $userId");
        }
      }).onError((e, stack) {
        firebaseCrashlytics.recordError(e, stack);
        throw UserException(message: "Error getting user information");
      });
      return result;
    } catch (e, stack) {
      firebaseCrashlytics.recordError(e, stack);
      throw UserException(message: ErrorConstants.unhandled);
    }
  }

  @override
  Future<bool> updateCurrentUser(UserModel user) async {
    try {
      final result = await firebaseFirestore
          .collection("users")
          .doc(user.id)
          .update(user.toJson())
          .then((_) => true)
          .onError((e, stack) {
        firebaseCrashlytics.recordError(e, stack);
        throw UserException(message: "Error updating user");
      });
      return result;
    } catch (e, stack) {
      firebaseCrashlytics.recordError(e, stack);
      throw UserException(message: ErrorConstants.unhandled);
    }
  }
}

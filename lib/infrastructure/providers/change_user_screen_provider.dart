import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/infrastructure/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangeUserScreenProvider with ChangeNotifier{
  Ref ref;
  
  ChangeUserScreenProvider(this.ref);

  Future<List<UserModel>> getUserList() async {
    final getParentUserChildrenRef = ref.watch(getParentUserChildrenUseCase);
    final result = await getParentUserChildrenRef.getParentUserChildren();
    return result;  
  }
}
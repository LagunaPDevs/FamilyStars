import 'package:familystars_2/infrastructure/domain/repositories/user_repository.dart';
import 'package:familystars_2/infrastructure/errors/result.dart';
import 'package:familystars_2/infrastructure/models/user.dart';
import 'package:familystars_2/infrastructure/services/shared_preference_services.dart';

class GetParentUserChildrenUseCase {
  final UserRepository userRepository;

  GetParentUserChildrenUseCase({required this.userRepository});

  Future<List<UserModel>> getParentUserChildren() async {
    final currentUser = SharedPreferenceService().getUser();
    final result = await userRepository.getParentUserChildren(currentUser ?? "");
    switch(result){
      case Ok():
      return result.result;
      case Error():
      return [];
    }
  }
}
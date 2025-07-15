import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familystars_2/infrastructure/data_sources/rewards_data_source.dart';
import 'package:familystars_2/infrastructure/domain/repositories/rewards_repository.dart';
import 'package:familystars_2/infrastructure/errors/exceptions.dart';

class RewardsRepositoryImpl extends RewardsRepository{
  final RewardsDataSource dataSource;

  RewardsRepositoryImpl({required this.dataSource});

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>>? getRewardsFromCategory(String category) {
    try{
      final result = dataSource.getRewardsFromCategory(category);
      return result;
    } on RewardException catch (_){
      return null;
    }
  }
}
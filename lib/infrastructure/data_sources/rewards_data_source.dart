import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familystars_2/infrastructure/constants/error_constants.dart';
import 'package:familystars_2/infrastructure/errors/exceptions.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

abstract class RewardsDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>>? getRewardsFromCategory(String category);

}

class RewardsDataSourceImpl extends RewardsDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseCrashlytics firebaseCrashlytics;

  RewardsDataSourceImpl({required this.firebaseFirestore, required this.firebaseCrashlytics});
  
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>>? getRewardsFromCategory(String category)  {
    try {
      final result = firebaseFirestore.collection('rewards').where('category', isEqualTo: category);
      return result.snapshots();
    } catch(e, stack){
      firebaseCrashlytics.recordError(e, stack);
      throw RewardException(message: ErrorConstants.unhandled);
    }
  }
}
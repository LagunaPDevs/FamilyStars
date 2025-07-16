import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RewardsRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>>? getRewardsFromCategory(String category);
}
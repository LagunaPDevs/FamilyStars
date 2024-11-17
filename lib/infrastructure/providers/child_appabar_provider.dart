import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This class represents a provider that catch events in 'ChildAppBar'
// and notify about changes in it attributes

class ChildAppBarProvider extends ChangeNotifier {
  ProviderReference ref;
  ChildAppBarProvider(this.ref);

  String childId = '';
  String get getChildId => childId;

  void setChildId(String id) {
    childId = id;
    notifyListeners();
  }

  String childStars = '';
  String get getChildStars => childStars;

  void setChildStars(String stars) {
    childStars = stars;
    notifyListeners();
  }
}

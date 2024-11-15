import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This class represents a provider that catch events in 'CalendarScreen'
// and notify about changes in it attributes

class CalendarScreenProvider extends ChangeNotifier {
  ProviderReference ref;

  CalendarScreenProvider(this.ref);

  bool monthView = true;

  bool get isMonthView => monthView;

  void setMonthView(bool monthview) {
    monthView = monthview;
    notifyListeners();
  }
}

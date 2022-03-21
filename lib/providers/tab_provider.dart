import 'package:flutter/widgets.dart';

class TabProvider extends ChangeNotifier {
  int currentIndex = 0;
  int currentIndexAt = 0;
  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void changeCurrentIndexAt(int index) {
    currentIndexAt = index;
    notifyListeners();
  }
}

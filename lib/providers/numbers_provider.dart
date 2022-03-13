import 'package:flutter/widgets.dart';

class PhoneNumbersProvider extends ChangeNotifier {
  String dropValue = "+998";
  void changePrefix(String number) {
    dropValue = number;
    notifyListeners();
  }
}

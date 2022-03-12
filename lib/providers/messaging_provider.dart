import 'package:flutter/widgets.dart';

class MessagingProvider extends ChangeNotifier {
  bool isComplete = false;

  void showSendButton(String data) {
    if (data.isNotEmpty) {
      isComplete = true;
      notifyListeners();
    } else {
      isComplete = false;
      notifyListeners();
    }
  }
}

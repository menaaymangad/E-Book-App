import 'package:flutter/cupertino.dart';

class AdminModel extends ChangeNotifier {
  bool isAdmin = false;
  changeIsAdmin(bool value) {
    isAdmin = value;
    notifyListeners();
  }
}

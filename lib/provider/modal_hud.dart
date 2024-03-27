import 'package:flutter/cupertino.dart';

class ModalHud extends ChangeNotifier {
  bool isLoading = false;
  changeIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners(); // Notify listeners of changes
  }
}

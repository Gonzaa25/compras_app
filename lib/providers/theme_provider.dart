import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _usedarktheme = false;
  bool get usedarktheme => _usedarktheme;

  void changeTheme(bool usedarkTheme) {
    _usedarktheme = usedarkTheme;
    notifyListeners();
  }
}

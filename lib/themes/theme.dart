import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  ColorScheme appColorScheme;

  AppTheme({
    this.appColorScheme = const ColorScheme.dark(),
  });

  void changeToLightTheme() {
    appColorScheme = const ColorScheme.light();
    notifyListeners();
  }

  void changeToDarkTheme() {
    appColorScheme = const ColorScheme.dark();
    notifyListeners();
  }
}

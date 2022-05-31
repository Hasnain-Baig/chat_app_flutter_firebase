import 'package:flutter/material.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _isDark = false;
  ThemeMode get currentMode => _isDark ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }

  static get lightTheme {
    // return ThemeData(
    //   primaryColor: Colors.purple,
    //   primarySwatch: Colors.purple,
    // );
    return ThemeData(
      colorScheme: ColorScheme(
        primary: Color(0xFFEC407A),
        onPrimary: Colors.white,
        secondary: Colors.white,
        onSecondary: Colors.black87,
        primaryVariant: Color(0xFF880E4F),
        secondaryVariant: Colors.black12,
        background: Colors.orange,
        onBackground: Colors.white,
        surface: Color(0xFFEC407A),
        onSurface: Colors.grey,
        error: Colors.red,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFFEC407A),
      ),
    );
  }

  static get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme(
        primary: Color(0xFFEC407A),
        onPrimary: Colors.white,
        secondary: Colors.black12,
        onSecondary: Colors.white,
        primaryVariant: Color(0xFF880E4F),
        secondaryVariant: Colors.black87,
        background: Colors.orange,
        onBackground: Colors.white,
        surface: Color(0xFFEC407A),
        onSurface: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        brightness: Brightness.dark,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFFEC407A),
      ),
    );
  }
}

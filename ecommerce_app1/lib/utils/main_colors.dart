// theme.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppTheme {
  // Light mode colors
  static const Color lightBackgroundColor = Color.fromRGBO(238, 237, 236, 1);
  static const Color lightTextColor = Color.fromRGBO(82, 81, 81, 1);
  static const Color lightSecondaryColor = Color.fromRGBO(251, 251, 251, 1);

  // Dark mode colors
  static const Color darkBackgroundColor = Color.fromRGBO(22, 22, 22, 1);
  static const Color darkTextColor = Color.fromRGBO(156, 156, 156, 1);
  static const Color darkSecondaryColor = Color.fromRGBO(26, 26, 26, 1);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: lightBackgroundColor,
      secondary: lightBackgroundColor,
      surface: lightSecondaryColor,
      onSurface: lightTextColor,
      onSecondary: lightTextColor,
    ),
    scaffoldBackgroundColor: lightBackgroundColor,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: lightTextColor),
      bodyMedium: TextStyle(color: lightTextColor),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: darkBackgroundColor,
      secondary: darkBackgroundColor,
      surface: darkSecondaryColor,
      onSurface: darkTextColor,
      onSecondary: darkTextColor,
    ),
    scaffoldBackgroundColor: darkBackgroundColor,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: darkTextColor),
      bodyMedium: TextStyle(color: darkTextColor),
    ),
  );
}

////
///
///

class ThemeModel extends ChangeNotifier {
  bool isDarkMode = false;

  ThemeModel() {
    _loadTheme();
  }

  ThemeMode get currentTheme => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    Hive.box('settingsBox').put('isDarkMode', isDarkMode); // Save the setting
    notifyListeners();
  }

  void _loadTheme() {
    var box = Hive.box('settingsBox');
    isDarkMode = box.get('isDarkMode', defaultValue: false); // Load the setting
  }
}

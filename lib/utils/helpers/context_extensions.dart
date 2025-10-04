import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  /// Access ThemeData directly
  ThemeData get theme => Theme.of(this);

  /// Access TextTheme directly
  TextTheme get textTheme => theme.textTheme;

  /// Access ColorScheme directly
  ColorScheme get colorScheme => theme.colorScheme;

  /// Check if dark mode is active
  /// isDarkMode from Get Package → checks your app's current theme (after ThemeMode.system, ThemeMode.dark, or ThemeMode.light is resolved).
  /// isDarkModeMedia → checks the device system preference (Android/iOS dark mode setting), regardless of what your app is using.
  bool get isDarkModeMedia =>
      MediaQuery.of(this).platformBrightness == Brightness.dark;
}

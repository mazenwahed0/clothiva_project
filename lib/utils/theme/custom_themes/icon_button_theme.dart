import 'package:flutter/material.dart';

/// Light & Dark Icon Button Themes
class CIconButtonTheme {
  CIconButtonTheme._();

  /// Light Theme
  static final lightIconButtonTheme = IconButtonThemeData(
    style: ButtonStyle(
      iconSize: const WidgetStatePropertyAll(20), // default size
      foregroundColor: WidgetStatePropertyAll(Colors.black), // active color
      backgroundColor: WidgetStatePropertyAll(Colors.transparent),
      overlayColor: WidgetStatePropertyAll(Colors.blue.withValues(alpha: 0.1)),
    ),
  );

  /// Dark Theme
  static final darkIconButtonTheme = IconButtonThemeData(
    style: ButtonStyle(
      iconSize: const WidgetStatePropertyAll(20),
      foregroundColor: WidgetStatePropertyAll(Colors.white), // white icons
      backgroundColor: WidgetStatePropertyAll(Colors.transparent),
      overlayColor: WidgetStatePropertyAll(Colors.white24),
    ),
  );
}

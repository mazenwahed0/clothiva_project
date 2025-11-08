import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  static ThemeController get instance => Get.find();

  final _box = GetStorage();

  // We use the ThemeMode enum, defaulting to system
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    // Load the saved theme mode from storage: 'system' by default
    final String themeString = _box.read('themeMode') ?? 'system';

    // Set the themeMode value based on the stored string
    if (themeString == 'light') {
      themeMode.value = ThemeMode.light;
    } else if (themeString == 'dark') {
      themeMode.value = ThemeMode.dark;
    } else {
      themeMode.value = ThemeMode.system;
    }

    // Apply the loaded theme
    Get.changeThemeMode(themeMode.value);
  }

  /// Cycles through the three theme modes
  void cycleTheme() {
    if (themeMode.value == ThemeMode.system) {
      _updateTheme(ThemeMode.light, 'light');
    } else if (themeMode.value == ThemeMode.light) {
      _updateTheme(ThemeMode.dark, 'dark');
    } else {
      _updateTheme(ThemeMode.system, 'system');
    }
  }

  /// Helper function to apply the theme and save it to storage
  void _updateTheme(ThemeMode mode, String modeString) {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
    _box.write('themeMode', modeString);
  }
}

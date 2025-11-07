import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CDeviceUtils {
  // Hide keyboard
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  // Set status bar color
  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color),
    );
  }

  // Check if landscape orientation
  static bool isLandscapeOrientation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom == 0;
  }

  // Check if portrait orientation
  static bool isPortraitOrientation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom != 0;
  }

  // Set full-screen mode
  static void setFullScreen(bool enable) {
    SystemChrome.setEnabledSystemUIMode(
      enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge,
    );
  }

  // Function to get screen height
  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  // Function to get screen width
  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  // Get pixel ratio
  static double getPixelRatio() {
    return MediaQuery.of(Get.context!).devicePixelRatio;
  }

  // Get status bar height
  static double getStatusBarHeight() {
    return MediaQuery.of(Get.context!).padding.top;
  }

  // Get bottom navigation bar height
  static double getBottomNavigationBarHeight() {
    return kBottomNavigationBarHeight;
  }

  // Get AppBar height
  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  // Get keyboard height
  static double getKeyboardHeight() {
    final viewInsets = MediaQuery.of(Get.context!).viewInsets;
    return viewInsets.bottom;
  }

  // Check if keyboard is visible
  static Future<bool> isKeyboardVisible() async {
    final viewInsets = View.of(Get.context!).viewInsets;
    return viewInsets.bottom > 0;
  }

  // Check if physical device
  static Future<bool> isPhysicalDevice() async {
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  // Vibrate the device
  static void vibrate(Duration duration) {
    HapticFeedback.vibrate();
    Future.delayed(duration, () => HapticFeedback.vibrate());
  }

  // Set preferred orientations
  static Future<void> setPreferredOrientations(
    List<DeviceOrientation> orientations,
  ) async {
    await SystemChrome.setPreferredOrientations(orientations);
  }

  // Hide status bar
  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  // Show status bar
  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  // Check if there is an internet connection
  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  // Check if device is iOS
  static bool isIOS() {
    return Platform.isIOS;
  }

  // Check if device is Android
  static bool isAndroid() {
    return Platform.isAndroid;
  }

  // Launch a URL
  static void launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

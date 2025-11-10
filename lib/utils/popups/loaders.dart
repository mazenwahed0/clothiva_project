import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../constants/colors.dart';

class Loaders {
  static hideSnackBar() =>
      ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customToast({required message}) {
    final dark = Get.isDarkMode;
    Get.snackbar(
      '',
      '',
      titleText: const SizedBox.shrink(), // Hides the title
      messageText: Center(
        child: Text(
          message,
          // Use a style that will be visible on the background
          style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(
            color: dark ? CColors.white : CColors.dark,
          ),
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: dark
          ? CColors.darkerGrey.withValues(alpha: 0.9)
          : CColors.grey.withValues(alpha: 0.9),
      borderRadius: 30,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      padding: const EdgeInsets.all(12),
      duration: const Duration(seconds: 1, milliseconds: 200),
      isDismissible: true,
      barBlur: 0,
      overlayBlur: 0,
    );
  }

  static successSnackBar({required title, message = '', duration = 2}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: CColors.dashboardAppbarBackground,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon: const Icon(Iconsax.check, color: CColors.white),
    );
  }

  static warningSnackBar({required title, message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: CColors.white,
      backgroundColor: Colors.black54,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: CColors.white),
    );
  }

  static errorSnackBar({required title, message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: CColors.white,
      backgroundColor: Colors.red.shade600,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: CColors.white),
    );
  }
}

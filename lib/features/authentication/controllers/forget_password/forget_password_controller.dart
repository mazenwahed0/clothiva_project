import 'dart:async';

import 'package:clothiva_project/features/authentication/screens/passwordconfiguration/reset_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Timer observables
  final canResend = true.obs;
  final timerText = ''.obs;

  /// Internal timer
  Timer? _timer;
  DateTime? _resendStartTime;

  /// Send Reset Password Email
  sendPasswordResetEmail() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
        'Processing your request...',
        CImages.docerAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        Loaders.customToast(message: 'No Internet Connection');
        return;
      }
      // Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Send Email to Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(
        email.text.trim(),
      ); //.trim() to remove spaces

      // Remove Loader
      FullScreenLoader.stopLoading();
      //Show Success Message
      Loaders.successSnackBar(
        title: CTexts.emailResetSent,
        message: CTexts.emailLinkToResetPassword.tr,
      );

      // Start cooldown for resend
      startResendTimer(); // 60 seconds

      // Redirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoading();
      //Show Error Message
      Loaders.errorSnackBar(title: CTexts.ohSnap, message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    if (!canResend.value) return; // Prevent spamming
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
        'Processing your request...',
        CImages.docerAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        Loaders.customToast(message: 'No Internet Connection');
        return;
      }

      // Send Email to Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(
        email,
      ); //.trim() to remove spaces

      // Remove Loader
      FullScreenLoader.stopLoading();
      //Show Success Message
      Loaders.successSnackBar(
        title: CTexts.emailResetSent,
        message: CTexts.emailLinkToResetPassword.tr,
      );

      startResendTimer();
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoading();
      //Show Error Message
      Loaders.errorSnackBar(title: CTexts.ohSnap, message: e.toString());
    }
  }

  /// Start resend cooldown timer
  startResendTimer({int seconds = 60}) {
    _timer?.cancel();
    _resendStartTime = DateTime.now();
    canResend.value = false;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final elapsed = DateTime.now().difference(_resendStartTime!).inSeconds;
      final remaining = seconds - elapsed;

      if (remaining <= 0) {
        timer.cancel();
        _timer = null; // allow future timers
        canResend.value = true;
        timerText.value = '';
      } else {
        timerText.value = 'Resend email in ${remaining}s';
      }
    });
  }
}

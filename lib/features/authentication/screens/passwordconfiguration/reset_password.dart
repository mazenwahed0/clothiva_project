import 'package:clothiva_project/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:clothiva_project/features/authentication/screens/login/login.dart';
import 'package:clothiva_project/utils/constants/image_strings.dart';
import 'package:clothiva_project/utils/constants/text_strings.dart';
import 'package:clothiva_project/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/sizes.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  //Already created instance with Get.put on previous screen Forget Password
  final controller = ForgetPasswordController.instance;

  @override
  void initState() {
    super.initState();
    // Start cooldown timer when this screen opens
    controller.startResendTimer(); // only called once
    print(controller.canResend.value);
  }

  @override
  Widget build(BuildContext context) {
    controller.startResendTimer();
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(CSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///MARK: Image
            Image(
              image: AssetImage(CImages.resetEmail),
              width: CDeviceUtils.screenWidth() * 0.6,
            ),

            ///MARK: Email, Title & Subtitle
            Text(
              widget.email,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: CSizes.spaceBtItems),
            Text(
              CTexts.changeYourPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: CSizes.spaceBtItems),
            Text(
              CTexts.changeYourPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: CSizes.spaceBtSections),

            ///MARK: Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.offAll(() => LoginScreen()),
                child: Text(CTexts.done),
              ),
            ),

            Obx(
              () => SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: controller.canResend.value
                      ? () async {
                          controller.resendPasswordResetEmail(widget.email);
                          controller.startResendTimer();
                        }
                      : null,
                  child: controller.canResend.value
                      ? Text(CTexts.resendEmail1)
                      : Text(
                          controller.timerText.value,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: controller.canResend.value
                                    ? Theme.of(context)
                                          .colorScheme
                                          .primary // active color
                                    : Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.color, // countdown color
                              ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

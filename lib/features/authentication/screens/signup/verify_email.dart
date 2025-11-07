import 'package:clothiva_project/utils/constants/image_strings.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:clothiva_project/utils/constants/text_strings.dart';
import 'package:clothiva_project/utils/device/device_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../controllers/signup/verify_email_controller.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, required this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    ///Used *get.put* here to create a new instance as *get.put* to create a new instance for first time and for init state to be called
    ///But *get.find* will be called every time once the instance has been created (Get.find won't trigger the init state method) that's why we needed *get.put*
    final controller = Get.put(VerifyEmailController());

    return Scaffold(
      /// Appbar close icon will first Logout the user & then redirect back to Login Screen()
      /// Reason: We will store the data when user enters the Register Button on Previous screen.
      /// Whenever the user opens the app, we will check if email is verified or not.
      /// If not verified we will always show this Verification screen.
      appBar: CAppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await AuthenticationRepository.instance.logout();
            },
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
        showActions: true,
        showSkipButton: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              ///Image
              Image(
                image: AssetImage(CImages.verifyEmail),
                width: CDeviceUtils.screenWidth() * 0.6,
              ),

              ///Title & Subtitle
              Text(
                CTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CSizes.spaceBtItems),
              Text(
                email ?? '',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CSizes.spaceBtItems),
              Text(
                CTexts.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: CSizes.spaceBtSections),

              ///MARK:- Buttons

              /// Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.checkEmailVerificationStatus(),
                  child: Text(CTexts.continueBtn),
                ),
              ),

              const SizedBox(height: CSizes.spaceBtItems),

              /// Resend Email, You can also add timer
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => controller.sendEmailVerfication(),
                  child: Text(CTexts.resendEmail1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

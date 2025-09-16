import '/features/authentication/screens/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/animations/fade_in_animation/animation_design.dart';
import '../../../../../utils/animations/fade_in_animation/fade_in_animation_controller.dart';
import '../../../../../utils/animations/fade_in_animation/fade_in_animation_model.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/texts_strings.dart';
import '../login/login.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.animationIn();

    var mediaQuery = MediaQuery.of(context);
    var width = mediaQuery.size.width;
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkMode ? CColors.secondary : CColors.primary,
        body: Stack(
          children: [
            TFadeInAnimation(
              isTwoWayAnimation: false,
              durationInMs: 1200,
              animate: TAnimatePosition(
                bottomAfter: 0,
                bottomBefore: -100,
                leftBefore: 0,
                leftAfter: 0,
                topAfter: 0,
                topBefore: 0,
                rightAfter: 0,
                rightBefore: 0,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(CSizes.defaultSpace),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Hero(
                        tag: 'welcome-image-tag',
                        child: Image(
                            image: const AssetImage(CImages.welcomeScreenImage),
                            width: width * 0.7,
                            height: height * 0.6),
                      ),
                      const SizedBox(height: CSizes.spaceBtSections),
                      Column(
                        children: [
                          Text(CTexts.welcomeTitle,
                              style: Theme.of(context).textTheme.displayMedium),
                          const SizedBox(height: CSizes.sm),
                          Text(CTexts.welcomeSubTitle,
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center),
                        ],
                      ),
                      const SizedBox(height: CSizes.spaceBtSections),
                      Row(
                        children: [
                          Expanded(
                              child: OutlinedButton(
                                  onPressed: () =>
                                      Get.to(() => const LoginScreen()),
                                  child: Text(CTexts.login.toUpperCase()))),
                          const SizedBox(width: 10.0),
                          Expanded(
                              child: ElevatedButton(
                                  onPressed: () =>
                                      Get.to(() => const SignUpScreen()),
                                  child: Text(CTexts.signup.toUpperCase()))),
                        ],
                      ),
                    ],
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

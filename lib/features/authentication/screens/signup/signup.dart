import 'package:clothiva_project/features/authentication/screens/login/login.dart';
import 'package:clothiva_project/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:clothiva_project/utils/constants/colors.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:clothiva_project/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_buttons.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    bool dark = context.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        //Note: Use Get.off() instead of Get.to() when navigating
        //This replaces the current screen instead of stacking both
        leading: IconButton(
          onPressed: () => Get.off(LoginScreen()),
          icon: Icon(
            Icons.arrow_back,
            color: dark ? CColors.white : CColors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            spacing: CSizes.spaceBtSections,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///MARK: - Title
              Text(
                CTexts.signUpTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              ///MARK: - Form
              SignUpForm(),

              ///MARK: - Divider
              FormDivider(dividerText: CTexts.orSignInWith.capitalize!),

              /// MARK: - Footer
              SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

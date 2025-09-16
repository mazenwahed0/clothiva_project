import '/features/authentication/screens/signup/widgets/signup_form.dart';
import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/texts_strings.dart';
import '/utils/helpers/context_extensions.dart';
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
  // MARK: - Variables
  bool passwordHidden = true;

  @override
  Widget build(BuildContext context) {
    bool dark = context.isDarkMode || context.isDarkModeMedia;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back,
                  color: dark ? CColors.white : CColors.black)),
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
                SocialButtons()
              ],
            ),
          ),
        ));
  }
}

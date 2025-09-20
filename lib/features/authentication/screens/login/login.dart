import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '/utils/constants/sizes.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';
import '/common/styles/spacing_styles.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../utils/constants/text_strings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: CSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// MARK: - Logo, Title & Subtitle
              LoginHeader(),

              /// MARK: - Form
              LoginForm(),

              /// MARK: - Divider
              FormDivider(dividerText: CTexts.orSignInWith.capitalize!),

              const SizedBox(
                height: CSizes.spaceBtSections,
              ),

              /// MARK: - Footer
              SocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}

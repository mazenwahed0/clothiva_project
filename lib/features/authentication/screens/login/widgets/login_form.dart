import 'package:clothiva_project/features/authentication/controllers/login/login_controller.dart';
import 'package:clothiva_project/features/authentication/screens/passwordconfiguration/forget_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../signup/signup.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    //Without the two brackets if you're calling the alread created .instance
    //but here Get.put to create the first instance so brackets are needed
    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: CSizes.spaceBtSections),
        child: Column(
          children: [
            /// MARK: - Email Form
            TextFormField(
              controller: controller.email,
              validator: (value) => CValidator.validateEmail(value),
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: CTexts.email,
                prefixIcon: Icon(Iconsax.direct_right),
              ),
            ),
            const SizedBox(height: CSizes.spaceBtInputFields),

            /// MARK: - Password Form
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) =>
                    CValidator.validateEmptyText(CTexts.password, value),
                keyboardType: TextInputType.text,
                obscureText: controller
                    .hidePassword
                    .value, //Rxbool .value to get the bool
                decoration: InputDecoration(
                  labelText: CTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(
                      controller.hidePassword.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: CSizes.spaceBtInputFields / 2),

            /// MARK: - Remember Me & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Remember Me
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value =
                            !controller.rememberMe.value,
                      ),
                    ),
                    Text(CTexts.rememberMe),
                  ],
                ),

                //Forget Password
                TextButton(
                  onPressed: () => Get.to(() => ForgetPasswordScreen()),
                  child: Text(CTexts.forgotPassword),
                ),
              ],
            ),

            const SizedBox(height: CSizes.spaceBtSections),

            /// MARK: - Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                //Note: Get.to or any navigation always wants a widget.
                onPressed: () async {
                  await controller.emailAndPasswordLogin();
                },
                child: Text(CTexts.signIn),
              ),
            ),

            const SizedBox(height: CSizes.spaceBtItems),

            /// MARK: - Create Account Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                //Note: Use Get.off() instead of Get.to() when navigating
                //This replaces the current screen instead of stacking both
                onPressed: () => Get.off(() => SignUpScreen()),
                child: Text(CTexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

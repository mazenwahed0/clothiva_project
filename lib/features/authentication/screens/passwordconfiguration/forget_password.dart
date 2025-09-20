import 'package:clothiva_project/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:clothiva_project/utils/constants/text_strings.dart';
import 'package:clothiva_project/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(CSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///MARK: Headings
            Text(
              CTexts.forgetPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: CSizes.spaceBtItems),

            Text(
              CTexts.forgetPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: CSizes.spaceBtSections * 2),

            ///MARK: Text Field
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: CValidator.validateEmail,
                decoration: const InputDecoration(
                  labelText: CTexts.email,
                  prefixIcon: Icon(Iconsax.direct_right),
                ),
              ),
            ),
            const SizedBox(height: CSizes.spaceBtSections),

            ///MARK: Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.sendPasswordResetEmail(),
                child: const Text(CTexts.submit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:clothiva_project/features/personalization/controllers/user_controller.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:clothiva_project/utils/constants/text_strings.dart';
import 'package:clothiva_project/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      /// Mark:- Appbar
      appBar: CAppBar(
        title: Text('Re-Authenticate User'),
        showBackArrow: true,
        showActions: false,
        showSkipButton: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(CSizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Mark:- Text field and Button
                /// Email
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: CValidator.validateEmail,
                  decoration: InputDecoration(
                    labelText: CTexts.email,
                    prefixIcon: Icon(Iconsax.direct_right),
                  ),
                ),
                SizedBox(height: CSizes.spaceBtInputFields),

                /// Password
                Obx(
                  () => TextFormField(
                    controller: controller.verifyPassword,
                    validator: (value) =>
                        CValidator.validateEmptyText(CTexts.password, value),
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

                SizedBox(height: CSizes.spaceBtSections),

                /// Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        controller.reAuthenticateEmailAndPasswordUser(),
                    child: Text('Verify'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:clothiva_project/features/authentication/screens/signup/widgets/terms_conditions.dart';
import 'package:clothiva_project/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controllers/signup/signup_controller.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    bool dark = context.isDarkMode;
    return Form(
      key: controller.signupFormKey,
      child: Column(
        spacing: CSizes.spaceBtItems,
        children: [
          const SizedBox(width: CSizes.spaceBtItems),

          ///MARK: - First & Last Name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstname,
                  validator: (value) =>
                      CValidator.validateEmptyText(CTexts.firstName, value),
                  expands: false,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: CTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: CSizes.spaceBtInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastname,
                  validator: (value) =>
                      CValidator.validateEmptyText(CTexts.lastName, value),
                  expands: false,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: CTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),

          ///MARK: - Username
          TextFormField(
            controller: controller.username,
            validator: (value) =>
                CValidator.validateEmptyText(CTexts.username, value),
            expands: false,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: CTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),

          ///MARK: - E-mail
          TextFormField(
            controller: controller.email,
            validator: (value) => CValidator.validateEmail(value),
            expands: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: CTexts.email,
              prefixIcon: Icon(Iconsax.direct_send),
            ),
          ),

          ///MARK: - Phone Number
          TextFormField(
            controller: controller.phonenumber,
            validator: (value) => CValidator.validatePhoneNumber(value),
            expands: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: CTexts.phoneNumber,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),

          ///MARK: - Gender
          Obx(
            () => DropdownButtonFormField<String>(
              value: controller.selectedGender.value,
              items: controller.genders
                  .map(
                    (gender) =>
                        DropdownMenuItem(value: gender, child: Text(gender)),
                  )
                  .toList(),
              onChanged: (value) {
                controller.selectedGender.value = value;
              },
              validator: (value) =>
                  value == null ? "Please select a gender" : null,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.user_tag),
                labelText: "Gender",
              ),
              dropdownColor: dark ? CColors.darkerGrey : CColors.grey,
              isExpanded: true,
            ),
          ),

          /// Old Gender (DropdownMenuFormField)
          // Obx(
          //   () => DropdownMenuFormField<String>(
          //     initialSelection: controller.selectedGender.value,
          //     label: Text("Gender"),
          //     hintText: "Gender",
          //     leadingIcon: Icon(Iconsax.user_tag),
          //     width: double.infinity,
          //     dropdownMenuEntries: controller.genders
          //         .map(
          //           (gender) => DropdownMenuEntry(
          //             value: gender,
          //             label: gender,
          //             style: ButtonStyle(
          //               textStyle: WidgetStateProperty.all(
          //                 TextStyle(color: Colors.white, fontSize: 18),
          //               ),
          //             ),
          //           ),
          //         )
          //         .toList(),
          //     onSelected: (value) {
          //       controller.selectedGender.value = value;
          //     },
          //     validator: (value) =>
          //         value == null ? "Please select a gender" : null,
          //   ),
          // ),

          ///MARK: - Password
          //Obx is the observer widget like BLoCBuilder to redraw UI for stateless widget
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => CValidator.validatePassword(value),
              keyboardType: TextInputType.text,
              obscureText:
                  controller.hidePassword.value, //Rxbool .value to get the bool
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

          ///MARK: - Terms & Conditions Checkbox
          TermsConditions(),
          const SizedBox(width: CSizes.spaceBtItems),

          ///MARK: - Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: Text(CTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}

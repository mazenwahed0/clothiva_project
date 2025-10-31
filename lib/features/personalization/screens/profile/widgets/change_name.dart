import 'package:clothiva_project/common/widgets/appbar/appbar.dart';
import 'package:clothiva_project/features/personalization/screens/profile/profile.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:clothiva_project/utils/constants/text_strings.dart';
import 'package:clothiva_project/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../controllers/update_name_controller.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      /// Mark:- Custom Appbar
      appBar: CAppBar(
        title: Text(
          'Change Name',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
        showActions: false,
        showSkipButton: false,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(CSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headings
            Text(
              'Use real name for easy verification. This name will appear on several pages.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: CSizes.spaceBtSections),

            /// Text field and Button
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        CValidator.validateEmptyText('First name', value),
                    expands: false,
                    decoration: InputDecoration(
                      labelText: CTexts.firstName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  SizedBox(height: CSizes.spaceBtInputFields),
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) =>
                        CValidator.validateEmptyText('Last name', value),
                    expands: false,
                    decoration: InputDecoration(
                      labelText: CTexts.lastName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: CSizes.spaceBtSections),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateUserName(),
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

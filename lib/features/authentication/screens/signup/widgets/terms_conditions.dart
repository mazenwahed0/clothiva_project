import 'package:clothiva_project/features/authentication/controllers/signup/signup_controller.dart';
import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = context.isDarkMode || context.isDarkModeMedia;
    final controller = SignupController.instance;

    //Note1: SizedBox to remove extra space behind it
    //Note2: Text.rich code block may overflow on older devices if you use a different font from in the video
    //In that case Wrap Text.rich in a Expanded widget
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(
            () => Checkbox(
              value: controller.privacybox.value,
              onChanged: (value) =>
                  controller.privacybox.value = !controller.privacybox.value,
            ),
          ),
        ),
        const SizedBox(width: CSizes.spaceBtItems),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${CTexts.iAgreeTo} ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: CTexts.privacyPolicy,
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? CColors.white : CColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? CColors.white : CColors.primary,
                  ),
                ),
                TextSpan(
                  text: ' ${CTexts.and} ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: CTexts.termsOfUse,
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? CColors.white : CColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? CColors.white : CColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

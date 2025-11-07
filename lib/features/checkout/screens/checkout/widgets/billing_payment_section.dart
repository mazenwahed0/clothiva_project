import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/checkout_controller.dart';

class CBillingPaymentSection extends StatelessWidget {
  const CBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    bool dark = context.isDarkMode;
    return Column(
      children: [
        SectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        const SizedBox(height: CSizes.spaceBtItems / 2),
        Obx(
          () => Row(
            children: [
              RoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark
                    ? CColors.lightContainer
                    : CColors.darkGrey,
                padding: const EdgeInsets.all(CSizes.sm),
                child: Image(
                  image: AssetImage(
                    controller.selectedPaymentMethod.value.image,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: CSizes.spaceBtItems / 2),
              Text(
                controller.selectedPaymentMethod.value.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

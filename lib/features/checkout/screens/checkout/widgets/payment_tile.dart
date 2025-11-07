import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../models/payment_method_model.dart';
import '../../../controllers/checkout_controller.dart';

class CPaymentTile extends StatelessWidget {
  const CPaymentTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    bool dark = context.isDarkMode;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },
      leading: RoundedContainer(
        width: 40,
        height: 40,
        backgroundColor: dark ? CColors.white : CColors.darkGrey,
        padding: const EdgeInsets.all(CSizes.sm),
        child: Image(
          image: AssetImage(paymentMethod.image),
          fit: BoxFit.contain,
        ),
      ),
      title: Text(
        paymentMethod.name,
        style: TextStyle(color: dark ? CColors.white : CColors.black),
      ),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}

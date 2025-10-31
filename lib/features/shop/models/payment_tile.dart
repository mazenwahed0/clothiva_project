import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

import '../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../checkout/models/payment_method_model.dart';
import '../../checkout/controllers/checkout_controller.dart';

class TPaymentTile extends StatelessWidget {
  const TPaymentTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    // final controller = Get.put(CheckoutController());
    bool dark = context.isDarkMode || context.isDarkModeMedia;
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

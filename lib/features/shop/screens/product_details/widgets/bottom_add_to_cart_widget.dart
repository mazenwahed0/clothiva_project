import 'package:clothiva_project/common/widgets/icons/circular_icon.dart';
import 'package:clothiva_project/utils/constants/colors.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/texts/simple_title_text_with_icon.dart';
import '../../../../cart/controllers/cart_controller.dart';
import '../../../models/product_model.dart';

class CBottomAddToCart extends StatelessWidget {
  CartController get controller => CartController.instance;

  const CBottomAddToCart({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    controller.updateAlreadyAddedProductCount(product);
    final bool dark = context.isDarkMode;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CSizes.defaultSpace,
        vertical: CSizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? CColors.darkGrey : CColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(CSizes.cardRadiusLg),
          topRight: Radius.circular(CSizes.cardRadiusLg),
        ),
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: CColors.darkerGrey,
                  width: 40,
                  height: 40,
                  color: CColors.white,
                  onPressed: () => controller.productQuantityInCart.value < 1
                      ? null
                      : controller.productQuantityInCart.value -= 1,
                ),
                const SizedBox(width: CSizes.spaceBtItems),
                Text(
                  controller.productQuantityInCart.value.toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(width: CSizes.spaceBtItems),
                CircularIcon(
                  icon: Iconsax.add,
                  backgroundColor: CColors.black,
                  width: 40,
                  height: 40,
                  color: CColors.white,
                  onPressed: () => controller.productQuantityInCart.value += 1,
                ),
              ],
            ),

            /// -- Checkout Button
            ElevatedButton(
              onPressed: controller.productQuantityInCart.value < 1
                  ? null
                  : () => controller.addToCart(product),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(CSizes.md),
                backgroundColor: CColors.black,
                side: const BorderSide(color: CColors.black),
              ),
              child: TitleWithIcon(
                title: 'Add to Cart',
                icon: Iconsax.shopping_cart,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

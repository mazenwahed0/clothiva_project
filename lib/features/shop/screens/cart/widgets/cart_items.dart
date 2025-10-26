import 'package:clothiva_project/features/shop/controllers/product/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:clothiva_project/common/widgets/products/cart/cart_item.dart';
import 'package:clothiva_project/common/widgets/texts/product_price_text.dart';
import 'package:clothiva_project/common/widgets/products/cart/add_remove_button.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class CCartItems extends StatelessWidget {
  CartController get cartController => CartController.instance; ///////////
  const CCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    // final cartController = CartController.instance;
    // final cartController = Get.find<CartController>();

    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (_, __) =>
            const SizedBox(height: CSizes.spaceBtSections),
        itemCount: cartController.cartItems.length,
        itemBuilder: (_, index) => Obx(() {
          final item = cartController.cartItems[index];
          return Column(
            children: [
              /// Cart Item
              CCartItem(cartItem: item),
              if (showAddRemoveButtons)
                const SizedBox(height: CSizes.spaceBtSections),

              /// Add Remove Buttons Row With Total Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (showAddRemoveButtons)
                    Row(
                      children: [
                        /// Extra Space
                        const SizedBox(width: 70),

                        /// Add Reomve Buttons
                        CProductQuantityWithAddRemoveButton(
                          quantity: item.quantity,
                          add: () => cartController.addOneToCart(item),
                          remove: () => cartController.removeOneFromCart(item),
                        ),
                      ],
                    ),

                  /// Product Total Price
                  ProductPriceText(price: (item.price * item.quantity).toStringAsFixed(1)),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}

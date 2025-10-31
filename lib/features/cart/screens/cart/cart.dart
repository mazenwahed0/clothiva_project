import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:clothiva_project/utils/constants/image_strings.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/cart_controller.dart';
import '../../../checkout/screens/checkout/checkout.dart';
import 'widgets/cart_items.dart';

class CartScreen extends StatelessWidget {
  CartController get controller => CartController.instance; /////////////
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = CartController.instance;
    // final controller = Get.find<CartController>();
    return Scaffold(
      appBar: CAppBar(
        showActions: false,
        showSkipButton: false,
        showBackArrow: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Obx(() {
        // Nothing Found Widget
        final emptyWidget = CAnimationLoaderWidget(
          text: 'Whoops! Cart is EMPTY',
          animation: CImages.cartPage,
          showAction: true,
          actionText: 'Let\'s fill it',
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );

        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(CSizes.defaultSpace),
              child: CCartItems(),
            ),
          );
        }
      }),

      /// Checkout Button
      bottomNavigationBar: Obx(
        () => controller.cartItems.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.all(CSizes.defaultSpace),
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const CheckoutScreen()),
                  child: Text(
                    'Checkout \$${controller.totalCartPrice.value.toStringAsFixed(2)}',
                  ),
                ),
              ),
      ),
    );
  }
}

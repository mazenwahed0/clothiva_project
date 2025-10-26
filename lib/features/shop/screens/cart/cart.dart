import 'package:clothiva_project/common/widgets/appbar/appbar.dart';
import 'package:clothiva_project/common/widgets/loaders/animation_loader.dart';
import 'package:clothiva_project/features/shop/controllers/product/cart_controller.dart';
import 'package:clothiva_project/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:clothiva_project/features/shop/screens/checkout/checkout.dart';
import 'package:clothiva_project/navigation_menu.dart';
import 'package:clothiva_project/utils/constants/image_strings.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          animation: CImages.bagIcon,
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
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(CSizes.defaultSpace),
              child: ElevatedButton(
                onPressed: () => Get.to(() => const CheckoutScreen()),
                child: Obx(
                  () => Text('Checkout \$${controller.totalCartPrice.value.toStringAsFixed(2)}'),
                ),
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../features/cart/controllers/cart_controller.dart';
import '../../../../features/cart/screens/cart/cart.dart';
import '../../../../utils/constants/colors.dart';
import 'package:get/get.dart';

class CartCounterIcon extends StatelessWidget {
  const CartCounterIcon({
    super.key,
    this.iconColor,
    this.counterBgColor,
    this.counterTextColor,
  });

  final Color? iconColor, counterBgColor, counterTextColor;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => const CartScreen()),
          icon: Icon(Iconsax.shopping_cart, color: iconColor),
        ),
        Obx(() {
          if (controller.noOfCartItems.value != 0) {
            return Positioned(
              right: 0,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: CColors.red.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    controller.noOfCartItems.value.toString(),
                    style: Theme.of(context).textTheme.labelLarge!.apply(
                      color: CColors.white,
                      fontSizeFactor: 0.8,
                    ),
                  ),
                ),
              ),
            );
          }
          return SizedBox();
        }),
      ],
    );
  }
}

// class CartCounterIcon extends StatelessWidget {
//   const CartCounterIcon({
//     super.key,
//     required this.onPressed,
//     required this.iconColor,
//   });

//   final Color iconColor;
//   final VoidCallback onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         IconButton(
//           onPressed: () => Get.to(() => const CartScreen()),
//           icon: Icon(
//             Iconsax.shopping_bag,
//             color: iconColor,
//           ),
//         ),
//         Positioned(
//           right: 0,
//           child: Container(
//             width: 18,
//             height: 18,
//             decoration: BoxDecoration(
//               color: CColors.red.withValues(alpha: 0.8),
//               borderRadius: BorderRadius.circular(100),
//             ),
//             child: Center(
//               child: Text(
//                 '1',
//                 style: Theme.of(context)
//                     .textTheme
//                     .labelLarge!
//                     .apply(color: CColors.white, fontSizeFactor: 0.8),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:clothiva_project/features/shop/screens/product_details/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../../features/shop/controllers/product/cart_controller.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  CartController get cartController => CartController.instance; ////////////////////////
  const ProductCardAddToCartButton({
    required this.product,
    super.key,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    // final cartController = CartController.instance;
    // final cartController = Get.find<CartController>();
    
    return InkWell(
      onTap: () {

        if(product.productType == ProductType.variable.toString()) {
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);
        } else {
          Get.to(() => ProductDetailScreen(product: product));
        }
      },
      child: Obx(() {
        final productQuantityInCart = cartController.getProductQuantityInCart(product.id);
        return Container(
          decoration: BoxDecoration(
          color: productQuantityInCart > 0 ? CColors.primary : CColors.dark,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(CSizes.cardRadiusMd),
            bottomRight: Radius.circular(CSizes.productImageRadius),
          ),
        ),
        child: SizedBox(
          width: CSizes.iconLg * 1.2,
          height: CSizes.iconLg * 1.2,
          child: Center(
            child: productQuantityInCart > 0
            ? Text(productQuantityInCart.toString(), style: Theme.of(context).textTheme.bodyLarge!.apply(color: CColors.white),)
            : const Icon(Iconsax.add, color: CColors.white),
          ),
        ),
        );
      }
      ),
    );
  }
}

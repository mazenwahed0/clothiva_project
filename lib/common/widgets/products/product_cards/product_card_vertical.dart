import 'package:clothiva_project/common/styles/shadows.dart';
import 'package:clothiva_project/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:clothiva_project/common/widgets/images/rounded_image.dart';
import 'package:clothiva_project/common/widgets/texts/product_price_text.dart';
import 'package:clothiva_project/common/widgets/texts/product_title_text.dart';
import 'package:clothiva_project/features/shop/screens/product_details/product_detail.dart';
import 'package:clothiva_project/utils/constants/colors.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:clothiva_project/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/shop/controllers/products/product_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../texts/brand_title_text_with_verified_icon.dart';
import '../favourite_icon/favourite_icon.dart';
import 'add_to_cart_button.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = context.isDarkMode;
    final controller = ProductController.instance;
    final salePercentage = controller.CalculateSalePercentage(
      product.price,
      product.salePrice,
    );

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Container(
        width: 180,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [CShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(CSizes.productImageRadius),
          color: dark ? CColors.darkerGrey : CColors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Thumbnail, Wishlist Button, Discount Tag
            RoundedContainer(
              height: CDeviceUtils.screenHeight() * 0.17,
              padding: EdgeInsetsGeometry.all(CSizes.sm),
              backgroundColor: dark ? CColors.dark : CColors.white,
              child: Stack(
                children: [
                  /// -- Thumbnail Image
                  RoundedImage(
                    isNetworkImage: true,
                    imageUrl: product.thumbnail,
                    applyImageRadius: true,
                  ),

                  /// -- Sale Tag
                  if (salePercentage != null)
                    Positioned(
                      top: 12,
                      child: RoundedContainer(
                        radius: CSizes.sm,
                        backgroundColor: CColors.secondary.withValues(
                          alpha: 0.9,
                        ),
                        padding: EdgeInsetsGeometry.symmetric(
                          horizontal: CSizes.sm,
                          vertical: CSizes.xs,
                        ),
                        child: Text(
                          '$salePercentage%',
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge!.apply(color: CColors.black),
                        ),
                      ),
                    ),

                  /// -- Favourite Icon Button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: FavouriteIcon(productId: product.id),
                  ),
                ],
              ),
            ),
            SizedBox(height: CSizes.spaceBtItems / 2),

            ///Details
            Padding(
              padding: EdgeInsetsGeometry.only(left: CSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductTitleText(title: product.title, smallSize: true),
                  SizedBox(height: CSizes.spaceBtItems / 2),
                  Row(
                    children: [
                      BrandTitleWithVerifiedIcon(title: product.brand!.name),
                    ],
                  ),
                ],
              ),
            ),

            // Spacer() here to keep the height of each box same in case 1 or 2 lines of Headings
            const Spacer(),

            /// -- Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// -- Price
                Flexible(
                  child: Column(
                    children: [
                      if (product.productType ==
                              ProductType.single.toString() &&
                          product.salePrice > 0)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: CSizes.sm,
                          ),
                          child: Text(
                            '\$${product.price.toString()}',
                            style: Theme.of(context).textTheme.labelMedium!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: CSizes.sm,
                        ),
                        child: ProductPriceText(
                          price: controller.getProductPrice(product),
                        ),
                      ),
                    ],
                  ),
                ),

                /// Add to Cart Button
                ProductCardAddToCartButton(product: product),
                // Container(
                //   decoration: BoxDecoration(
                //     color: CColors.dark,
                //     borderRadius: BorderRadius.only(
                //       topLeft: Radius.circular(CSizes.cardRadiusMd),
                //       bottomRight: Radius.circular(CSizes.productImageRadius),
                //     ),
                //   ),
                //   child: SizedBox(
                //     width: CSizes.iconLg * 1.2,
                //     height: CSizes.iconLg * 1.2,
                //     child: Center(
                //       child: Icon(
                //         Iconsax.add,
                //         color: CColors.white,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

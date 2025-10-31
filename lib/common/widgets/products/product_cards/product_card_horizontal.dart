import 'package:clothiva_project/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:clothiva_project/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:clothiva_project/common/widgets/texts/product_price_text.dart';
import 'package:clothiva_project/common/widgets/texts/product_title_text.dart';
import 'package:clothiva_project/features/shop/models/product_model.dart';
import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/shop/controllers/products/product_controller.dart';
import '../../../../features/shop/screens/product_details/product_detail.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../images/rounded_image.dart';
import '../favourite_icon/favourite_icon.dart';
import 'add_to_cart_button.dart';

class ProductCardHorizontal extends StatelessWidget {
  const ProductCardHorizontal({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = context.isDarkMode || context.isDarkModeMedia;

    final controller = ProductController.instance;
    final salePercentage = controller.CalculateSalePercentage(
      product.price,
      product.salePrice,
    );

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Container(
        width: 310,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(CSizes.productImageRadius),
          color: dark ? CColors.darkerGrey : CColors.lightContainer,
        ),
        child: Row(
          children: [
            /// Thumbnail
            RoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(CSizes.sm),
              backgroundColor: dark ? CColors.dark : CColors.white,
              child: Stack(
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: RoundedImage(
                      imageUrl: product.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),

                  /// Sale Tag
                  if (salePercentage != null)
                    Positioned(
                      top: 12,
                      child: RoundedContainer(
                        radius: CSizes.sm,
                        backgroundColor: CColors.secondary.withOpacity(0.8),
                        padding: EdgeInsetsGeometry.symmetric(
                          horizontal: CSizes.sm,
                          vertical: CSizes.xs,
                        ),
                        child: Text(
                          "$salePercentage%",
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge!.apply(color: CColors.black),
                        ),
                      ),
                    ),

                  /// Favourite Icon Button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: FavouriteIcon(productId: product.id),
                  ),
                ],
              ),
            ), //RoundedContainer
            ///Details
            SizedBox(
              width: 172,
              child: Padding(
                padding: const EdgeInsets.only(top: CSizes.sm, left: CSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductTitleText(title: product.title, smallSize: true),
                        SizedBox(height: CSizes.spaceBtItems / 2),
                        BrandTitleWithVerifiedIcon(title: product.brand!.name),
                      ],
                    ),
                    const Spacer(),
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
                                    product.price.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .apply(
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
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
                        //       bottomRight:
                        //           Radius.circular(CSizes.productImageRadius),
                        //     ),
                        //   ),
                        //   child: SizedBox(
                        //     width: CSizes.iconLg * 1.2,
                        //     height: CSizes.iconLg * 1.2,
                        //     child: Center(
                        //       child: Icon(Iconsax.add, color: CColors.white),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

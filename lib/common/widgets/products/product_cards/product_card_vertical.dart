import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../styles/shadows.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../icons/circular_icon.dart';
import '../../images/rounded_image.dart';
import '../../texts/brand_title_text_with_verified_icon.dart';
import '../../texts/product_price_text.dart';
import '../../texts/product_title_text.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = context.isDarkMode || context.isDarkModeMedia;
    return GestureDetector(
      // onTap: () => Get.to(() => ProductDetailScreen()), //Add the ProductDetailScreen
      child: Container(
        width: 180,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [CShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(CSizes.productImageRadius),
          color: dark ? CColors.darkerGrey : CColors.white,
        ),
        child: Column(
          children: [
            /// Thumbnail, Wishlist Button, Discount Tag
            RoundedContainer(
              height: 180,
              padding: EdgeInsetsGeometry.all(CSizes.sm),
              backgroundColor: dark ? CColors.dark : CColors.white,
              child: Stack(
                children: [
                  /// -- Thumbnail Image
                  RoundedImage(
                    imageUrl: CImages.productImage4b,
                    applyImageRadius: true,
                  ),

                  /// -- Sale Tag
                  Positioned(
                    top: 12,
                    child: RoundedContainer(
                      radius: CSizes.sm,
                      backgroundColor: CColors.secondary.withValues(alpha: 0.9),
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: CSizes.sm,
                        vertical: CSizes.xs,
                      ),
                      child: Text(
                        '25%',
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
                    child: CircularIcon(
                      onPressed: () {},
                      icon: Iconsax.heart5,
                      color: Colors.red,
                    ),
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
                  ProductTitleText(
                    title: 'Green Nike Air Shoes',
                    smallSize: true,
                  ),
                  SizedBox(height: CSizes.spaceBtItems / 2),
                  Row(children: [BrandTitleWithVerifiedIcon(title: 'Nike')]),
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
                Padding(
                  padding: const EdgeInsets.all(CSizes.sm),
                  child: ProductPriceText(price: '35.0'),
                ),

                /// Add to Cart Button
                Container(
                  decoration: BoxDecoration(
                    color: CColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(CSizes.cardRadiusMd),
                      bottomRight: Radius.circular(CSizes.productImageRadius),
                    ),
                  ),
                  child: SizedBox(
                    width: CSizes.iconLg * 1.2,
                    height: CSizes.iconLg * 1.2,
                    child: Center(
                      child: Icon(Iconsax.add, color: CColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

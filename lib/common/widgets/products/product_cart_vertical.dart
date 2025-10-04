import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../styles/shadows.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../icons/circular_icon.dart';
import '../images/rounded_image.dart';
import '../texts/product_price_text.dart';
import '../texts/product_title_text.dart';


class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);

    // Container with side paddings, color, edges, radius and shadow
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [CShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(CSizes.productImageRadius),
          color: dark ? CColors.darkerGrey : CColors.white,
        ),
        child: Column(
          children: [
            // 1. Thumbnail, Wishlist Button, Discount Tag
            RoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(CSizes.sm),
              backgroundColor: dark ? CColors.dark : CColors.lightContainer,
              child: Stack(
                children: [
                  // Thumbnail Image
                  const RoundedImage(
                    imageUrl: CImages.productImage1,
                    applyImageRadius: true,
                  ),

                  // Sale Tag
                  Positioned(
                    top: 12,
                    child: RoundedContainer(
                      radius: CSizes.sm,
                      backgroundColor: Colors.yellow,
                      padding: const EdgeInsets.symmetric(horizontal: CSizes.sm, vertical: CSizes.xs),
                      child: Text('25%', style: Theme.of(context).textTheme.labelLarge!.apply(color: CColors.black),
                      ),
                    ),
                  ),

                  // Favourite Icon Button
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: CircularIcon(
                      icon: Iconsax.heart5,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: CSizes.spaceBtItems / 2),

            // 2. Details and Price (Wrapped in Expanded for consistent height in grid)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: CSizes.sm, right: CSizes.sm, bottom: CSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Title
                    const ProductTitleText(title: 'Green Nike Air Shoes', smallSize: true),
                    const SizedBox(height: CSizes.spaceBtItems / 2),

                    // Brand/Verified Icon
                    Row(
                      children: [
                        Text('Nike', overflow: TextOverflow.ellipsis, maxLines: 1,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(width: CSizes.xs),
                        const Icon(Iconsax.verify5, color: CColors.primary, size: CSizes.iconXs,
                        ),
                      ],
                    ),

                    // The Spacer is removed from here
                    // Use a Spacer/SizedBox ONLY if the parent Column has a fixed height.
                    const Spacer(),

                    // Price and Add to Cart Button (Now correctly aligned to the bottom)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Price
                        const ProductPriceText(price: '35.0'),

                        // Add to Cart Button
                        Container(
                          decoration: BoxDecoration(
                            color: CColors.dark,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(CSizes.cardRadiusMd),
                              bottomRight: Radius.circular(CSizes.productImageRadius),
                            ),
                          ),
                          child: const SizedBox(
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
            ),

            // Removed extra SizedBox at the bottom
          ],
        ),
      ),
    );
  }
}
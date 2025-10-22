import 'package:clothiva_project/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:clothiva_project/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:clothiva_project/common/widgets/texts/product_price_text.dart';
import 'package:clothiva_project/common/widgets/texts/product_title_text.dart';
import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../styles/shadows.dart';
import '../../icons/circular_icon.dart';
import '../../images/rounded_image.dart';
import '../favourite_icon/favourite_icon.dart';

class ProductCardHorizontal extends StatelessWidget {
  const ProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = context.isDarkMode || context.isDarkModeMedia;
    return Container(
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
                    imageUrl: CImages.productImage4,
                    applyImageRadius: true ,
                  ),
                ),

                /// Sale Tag
                Positioned(
                  top: 12,
                  child: RoundedContainer(
                    radius: CSizes.sm,
                    backgroundColor: CColors.secondary.withOpacity(0.8),
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: CSizes.sm,
                      vertical: CSizes.xs,
                    ),
                    child: Text("25%", style: Theme.of(context).textTheme.labelLarge!.apply(color: CColors.black),),
                  ),
                ),

                /// Favourite Icon Button
                Positioned(
                  top: 0,
                  right: 0,
                  child: FavouriteIcon(productId: '',),
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
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: CSizes.sm, left: CSizes.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductTitleText(title: 'Green Nike Half Sleaves Shirt', smallSize: true,),
                        SizedBox(height: CSizes.spaceBtItems / 2,),
                        BrandTitleWithVerifiedIcon(title: 'Nike')
                      ],
                    ),
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(child: ProductPriceText(price : '35.0')),


                        /// Add to cart Button
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
          ),
        ],
      ),
    );
  }
}

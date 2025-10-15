import 'package:clothiva_project/common/widgets/images/circular_image.dart';
import 'package:clothiva_project/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:clothiva_project/common/widgets/texts/product_title_text.dart';
import 'package:clothiva_project/utils/constants/enums.dart';
import 'package:clothiva_project/utils/constants/image_strings.dart';
import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class CProductMetaData extends StatelessWidget {
  const CProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = context.isDarkMode || context.isDarkModeMedia;
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price & Sale
        Row(
          children: [
             RoundedContainer(
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

            const SizedBox(width: CSizes.spaceBtItems,),

            Text('\$250', style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),),
            const SizedBox(width: CSizes.spaceBtItems,),
            const ProductPriceText(price: "175", isLarge: true,),
          ],
        ),
        const SizedBox(width: CSizes.spaceBtItems / 1.5),

        // Title
        const ProductTitleText(title: "Green Nike Sports Shirt"),
        const SizedBox(height: CSizes.spaceBtItems / 1.5),

        //Stock Status
        Row(
          children: [
            const ProductTitleText(title: "Status"),
            const SizedBox(height: CSizes.spaceBtItems),
            Text("In Stock", style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: CSizes.spaceBtItems / 1.5),

        // Brand
        Row(
          children: [
            CircularImage(
                image: CImages.cosmeticsIcon,
                width: 32,
                height: 32,
                overlayColor: dark ? CColors.white : CColors.black,
            ),
            const BrandTitleWithVerifiedIcon(title: "Nike" , brandTextSize: TextSizes.medium,),
          ],
        )

      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:clothiva_project/common/widgets/images/rounded_image.dart';
import 'package:clothiva_project/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:clothiva_project/common/widgets/texts/product_title_text.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:clothiva_project/utils/constants/image_strings.dart';
import 'package:clothiva_project/utils/constants/colors.dart';
import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:get/get.dart';

class CCartItem extends StatelessWidget {
  const CCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool dark = context.isDarkMode || context.isDarkModeMedia;

    return Row(
      children: [
        /// Image
        RoundedImage(imageUrl: CImages.productImage4,
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(CSizes.sm),
        backgroundColor: dark ? CColors.darkerGrey : CColors.lightGrey,
        ),
        const SizedBox(width: CSizes.spaceBtItems,),
    
        /// Title, Price & Size
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BrandTitleWithVerifiedIcon(title: 'Nike'),
              const ProductTitleText(title: 'Black Sports Shoes', maxLines: 1),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: 'Color ',
                        style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(
                        text: 'Green ',
                        style: Theme.of(context).textTheme.bodyLarge),
                    TextSpan(
                        text: 'Size ',
                        style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(
                        text: 'UK 08 ',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
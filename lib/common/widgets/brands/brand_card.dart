import 'package:clothiva_project/features/shop/models/brand_model.dart';
import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../images/circular_image.dart';
import '../texts/brand_title_text_with_verified_icon.dart';

class CBrandCard extends StatelessWidget {
  const CBrandCard({super.key, this.onTap, required this.showBorder, required this.brand});

  final bool showBorder;
  final void Function()? onTap;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    bool dark = context.isDarkMode || context.isDarkModeMedia;

    return GestureDetector(
      onTap: onTap,

      /// Container Design
      child: RoundedContainer(
        padding: const EdgeInsets.all(CSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            /// -- Icon
            Flexible(
              child: CircularImage(
                isNetworkImage: false,
                image: brand.image,
                backgroundColor: Colors.transparent,
                overlayColor: dark ? CColors.white : CColors.black,
              ),
            ),

            const SizedBox(width: CSizes.spaceBtItems / 2),

            /// -- Text
            // [Expanded] & Column [MainAxisSize.min] is important to keep the elements in the vertical ceneter and also to keep text inside boundaries.
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   BrandTitleWithVerifiedIcon(
                    title:brand.name,
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    '${brand.productsCount??0} products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

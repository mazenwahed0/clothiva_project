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
  const CBrandCard({super.key, this.onTap, required this.showBorder});

  final bool showBorder;
  final void Function()? onTap;

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
                image: CImages.clothIcon,
                backgroundColor: Colors.transparent,
                overlayColor: dark ? CColors.white : CColors.black,
              ),
            ),

            const SizedBox(width: CSizes.spaceBtItems / 2),

            /// -- Text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BrandTitleWithVerifiedIcon(
                    title: 'Nike',
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    '256 products with asjsbd sj',
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

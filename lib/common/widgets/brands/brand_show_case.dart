
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import 'brand_cart.dart';


class CBrandShowcase extends StatelessWidget {
  const CBrandShowcase({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      showBorder: true,
      borderColor: CColors.darkGrey,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(CSizes.md),
      margin: const EdgeInsets.only(bottom: CSizes.spaceBtItems),
      child: Column(
        children: [
          // /// Brand with Products Count
          const BrandCard(showBorder: false),

          const SizedBox(height: CSizes.spaceBtItems),

          // /// Brand Top 3 Product Images
          Row(
            // It seems 'images' is expected to contain paths for the top 3 images.
            children: images.map((image) => brandTopProductImageWidget(image, context)).toList(),
          ),
        ],
      ), // Column
    ); // TRoundedContainer
  }
}

Widget brandTopProductImageWidget(String image, BuildContext context) {

  return Expanded(
    child: RoundedContainer(
      height: 100,
      padding: const EdgeInsets.all(CSizes.sm),
      // Adding a margin to the right separates the images in the row
      margin: const EdgeInsets.only(right: CSizes.sm),
      backgroundColor: CHelperFunctions.isDarkMode(context) ? CColors.darkerGrey : CColors.lightContainer,
      child: Image(fit: BoxFit.contain, image: AssetImage(image),
      ),
    ), // TRoundedContainer
  ); // Expanded
}
import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../custom_shapes/containers/rounded_container.dart';
import 'brand_card.dart';

class CBrandShowcase extends StatelessWidget {
  const CBrandShowcase({super.key, required this.images});

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
          /// Brand with Products Count
          CBrandCard(showBorder: false,brand: BrandModel.empty(),),

          const SizedBox(height: CSizes.spaceBtItems),

          /// Brand Top 3 Product Images
          Row(
            // It seems 'images' is expected to contain paths for the top 3 images.
            children: images
                .map((image) => brandTopProductImageWidget(image, context))
                .toList(),
          ),
        ],
      ),
    );
  }
}

Widget brandTopProductImageWidget(String image, BuildContext context) {
  bool dark = context.isDarkMode || context.isDarkModeMedia;
  return Expanded(
    child: RoundedContainer(
      height: 100,
      padding: const EdgeInsets.all(CSizes.sm),
      // Adding a margin to the right separates the images in the row
      margin: const EdgeInsets.only(right: CSizes.sm),
      backgroundColor: dark ? CColors.darkerGrey : CColors.lightContainer,
      child: Image(fit: BoxFit.contain, image: AssetImage(image)),
    ),
  );
}

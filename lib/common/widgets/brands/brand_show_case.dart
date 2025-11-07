import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../features/shop/screens/brand/brand_products.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../shimmers/shimmer.dart';
import 'brand_card.dart';

class CBrandShowcase extends StatelessWidget {
  const CBrandShowcase({super.key, required this.images, required this.brand});

  final List<String> images;
  final BrandModel brand;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandProducts(brand: brand)),
      child: RoundedContainer(
        showBorder: true,
        borderColor: CColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(CSizes.md),
        margin: const EdgeInsets.only(bottom: CSizes.spaceBtItems),
        child: Column(
          children: [
            /// Brand with Products Count
            CBrandCard(showBorder: false, brand: brand),

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
      ),
    );
  }
}

Widget brandTopProductImageWidget(String image, BuildContext context) {
  bool dark = context.isDarkMode;
  return Expanded(
    child: RoundedContainer(
      height: 100,
      padding: const EdgeInsets.all(CSizes.sm),
      // Adding a margin to the right separates the images in the row
      margin: const EdgeInsets.only(right: CSizes.sm),
      backgroundColor: dark ? CColors.darkerGrey : CColors.lightContainer,
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.contain,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CShimmerEffect(width: 100, height: 100),
      ),
    ),
  );
}

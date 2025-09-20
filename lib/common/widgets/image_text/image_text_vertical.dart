import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../images/circular_image.dart';
import '../texts/brand_title_text.dart';

class VerticalImageAndText extends StatelessWidget {
  const VerticalImageAndText({
    super.key,
    this.onTap,
    required this.image,
    required this.title,
    this.backgroundColor,
    this.textColor = CColors.white,
  });

  final Color textColor;
  final String image, title;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    // final dark = THelperFunctions.isDarkMode(context);
    bool dark = context.isDarkMode || context.isDarkModeMedia;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: CSizes.spaceBtItems),
        child: Column(
          children: [
            /// Circular Icon
            CircularImage(
              image: image,
              fit: BoxFit.fitWidth,
              padding: CSizes.sm * 1.4,
              backgroundColor: backgroundColor,
              overlayColor: dark ? CColors.white : CColors.dark,
            ),
            const SizedBox(height: CSizes.spaceBtItems / 2),

            /// Text
            SizedBox(
              width: 55,
              child: BrandTitleText(title: title, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}

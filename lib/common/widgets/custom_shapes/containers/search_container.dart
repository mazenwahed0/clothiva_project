import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap, // Added from the screenshot
    this.padding = const EdgeInsets.symmetric(horizontal: CSizes.defaultSpace), // Updated padding to be optional/default
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap; // Final property for the onTap callback
  final EdgeInsetsGeometry padding; // Final property for custom padding

  @override
  Widget build(BuildContext context) {
    // Note: The screenshot shows THelperFunctions, using your CHelperFunctions
    final dark = CHelperFunctions.isDarkMode(context);

    // The entire widget is now wrapped in a GestureDetector (from the screenshot)
    return GestureDetector(
      onTap: onTap, // Apply the onTap callback
      // The screenshot shows 'padding: padding' here, so we apply the property 'padding'
      child: Padding(
        padding: padding,
        // The rest of the content is wrapped in a Container (from the screenshot)
        child: Container(
          // Note: The screenshot uses TDeviceUtils.getScreenWidth, using your CDeviceUtils
          width: CDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(CSizes.md),
          decoration: BoxDecoration(
            // Note: The screenshot uses TColors.dark/light, using your CColors.dark/lightContainer
            color: showBackground
                ? dark
                ? CColors.dark
                : CColors.lightContainer
                : Colors.transparent,
            // Note: The screenshot uses TColors.cardRadiusLg, using your CSizes.cardRadiusLg
            borderRadius: BorderRadius.circular(CSizes.cardRadiusLg),
            // Note: The screenshot uses TColors.grey, using your CColors.grey
            border: showBorder ? Border.all(color: CColors.grey) : null,
          ),
          child: Row(
            children: [
              // Note: The screenshot uses TColors.darkerGrey, using your CColors.darkerGrey
              Icon(icon, color: CColors.darkerGrey),
              const SizedBox(width: CSizes.spaceBtItems), // Changed from spaceBtSections to spaceBtwItems for better spacing in a search bar
              Text(text, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ), // end of Container
      ), // end of Padding
    ); // end of GestureDetector
  }
}
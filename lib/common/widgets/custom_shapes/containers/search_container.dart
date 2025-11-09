import 'package:clothiva_project/features/shop/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showborder = true,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showborder;

  @override
  Widget build(BuildContext context) {
    bool dark = context.isDarkMode;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: CSizes.defaultSpace),
      child: GestureDetector(
        onTap: () => Get.to(() => SearchScreen()),
        child: Container(
          width: CDeviceUtils.screenWidth(),
          padding: EdgeInsets.all(CSizes.md),
          decoration: BoxDecoration(
            color: showBackground
                ? dark
                      ? CColors.dark
                      : CColors.lightContainer
                : Colors.transparent,
            borderRadius: BorderRadius.circular(CSizes.cardRadiusLg),
            border: showborder ? Border.all(color: CColors.grey) : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: CColors.darkerGrey),
              SizedBox(width: CSizes.spaceBtItems),
              Text(text, style: Theme.of(context).textTheme.bodySmall!),
            ],
          ),
        ),
      ),
    );
  }
}

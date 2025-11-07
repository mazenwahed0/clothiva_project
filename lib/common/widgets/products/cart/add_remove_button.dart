import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../icons/circular_icon.dart';

class CProductQuantityWithAddRemoveButton extends StatelessWidget {
  const CProductQuantityWithAddRemoveButton({
    super.key,
    required this.quantity,
    required this.add,
    required this.remove,
  });

  final int quantity;
  final VoidCallback? add, remove;

  @override
  Widget build(BuildContext context) {
    bool dark = context.isDarkMode;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: CSizes.md,
          color: dark ? CColors.white : CColors.black,
          backgroundColor: dark
              ? CColors.darkGrey
              // : CColors.light,
              : CColors.lightContainer,
          onPressed: remove,
        ),
        const SizedBox(width: CSizes.spaceBtItems),
        Text(
          quantity.toString(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(width: CSizes.spaceBtItems),
        CircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: CSizes.md,
          color: CColors.white,
          backgroundColor: CColors.primary,
          onPressed: add,
        ),
      ],
    );
  }
}

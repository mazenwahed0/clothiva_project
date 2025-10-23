import 'package:flutter/material.dart';
import 'package:clothiva_project/common/widgets/icons/circular_icon.dart';
import 'package:clothiva_project/utils/constants/colors.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class CProductQuantityWithAddRemoveButton extends StatelessWidget {
  const CProductQuantityWithAddRemoveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool dark = context.isDarkMode || context.isDarkModeMedia;
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
              : CColors.light,
        ),
        const SizedBox(width: CSizes.spaceBtItems),
        Text('2', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(width: CSizes.spaceBtItems),
    
        CircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: CSizes.md,
          color: CColors.white,
          backgroundColor: CColors.primary,
        ),
      ],
    );
  }
}

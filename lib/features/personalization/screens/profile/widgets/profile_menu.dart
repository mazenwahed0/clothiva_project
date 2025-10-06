import 'package:clothiva_project/utils/constants/colors.dart';
import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../../utils/constants/sizes.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.onPressed,
    required this.title,
    required this.value,
    this.icon = Iconsax.arrow_right_34,
    required this.isLoading,
  });

  final String title, value;
  final RxBool isLoading;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    bool dark = context.isDarkMode || context.isDarkModeMedia;
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: CSizes.spaceBtItems / 1.5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Obx(() {
              return isLoading.value
                  ? Expanded(
                      flex: 5,
                      child: CShimmerEffect(width: 80, height: 15),
                    )
                  : Expanded(
                      flex: 5,
                      child: Text(
                        value,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
            }),
            // Expanded(
            //   flex: 5,
            //   child: Text(
            //     value,
            //     style: Theme.of(context).textTheme.bodyMedium,
            //     overflow: TextOverflow.ellipsis,
            //   ),
            // ),
            Expanded(
              child: Icon(
                icon,
                size: 18,
                color: dark ? CColors.white : CColors.dark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

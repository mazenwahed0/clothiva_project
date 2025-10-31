import 'package:clothiva_project/common/widgets/shimmers/shimmer.dart';
import 'package:clothiva_project/features/personalization/controllers/user_controller.dart';
import 'package:clothiva_project/utils/helpers/exports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../utils/constants/colors.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return CAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${CHelperFunctions.getGreetingMessage()},',
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.apply(color: CColors.grey),
          ),
          Obx(() {
            if (controller.profileLoading.value) {
              // Display a shimmer loader while user profile is being loaded
              return CShimmerEffect(width: 80, height: 15);
            } else {
              return Text(
                controller.user.value.fullName,
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall!.apply(color: CColors.white),
              );
            }
          }),
        ],
      ),
      actions: [CartCounterIcon(iconColor: CColors.white)],
      showActions: true,
      showSkipButton: false,
    );
  }
}

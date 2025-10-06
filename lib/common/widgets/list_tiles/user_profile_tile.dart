import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/personalization/controllers/user_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../images/circular_image.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Obx(() {
      final networkImage = controller.user.value.profilePicture;
      final image = networkImage.isNotEmpty ? networkImage : CImages.user;
      return ListTile(
        leading: CircularImage(
          image: image,
          width: 50,
          height: 50,
          padding: 0,
          isNetworkImage: networkImage.isNotEmpty,
        ),
        title: Text(
          controller.user.value.fullName,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall!.apply(color: CColors.white),
        ),
        subtitle: Text(
          controller.user.value.email,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.apply(color: CColors.white),
        ),
        trailing: IconButton(
          onPressed: onPressed,
          icon: Icon(Iconsax.edit, color: CColors.white),
        ),
      );
    });
  }
}

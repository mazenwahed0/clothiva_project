import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/products/favourites_controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../icons/circular_icon.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = FavouritesController.instance;
    return Obx(
      () => CircularIcon(
        icon: controller.isFavourite(productId)
            ? Iconsax.heart5
            : Iconsax.heart,
        color: controller.isFavourite(productId) ? CColors.error : null,
        onPressed: () => controller.toggleFavouriteProduct(productId),
      ),
    );
  }
}

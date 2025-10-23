import 'package:clothiva_project/common/widgets/icons/circular_icon.dart';
import 'package:clothiva_project/features/shop/controllers/product/favourites_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(FavouritesController());
    return Obx(()=>CircularIcon(
      icon: controller.isFavourite(productId)? Iconsax.heart5:Iconsax.heart,
      color: controller.isFavourite(productId)? CColors.error:null,
      onPressed: ()=>controller.toggleFavouriteProduct(productId),
    ));
  }
}

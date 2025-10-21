import 'package:clothiva_project/common/widgets/appbar/appbar.dart';
import 'package:clothiva_project/common/widgets/icons/circular_icon.dart';
import 'package:clothiva_project/common/widgets/layouts/grid_layout.dart';
import 'package:clothiva_project/features/shop/controllers/product/product_controller.dart';
import 'package:clothiva_project/features/shop/screens/home/home.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =Get.put(ProductController());
    return Scaffold(
      appBar: CAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          CircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(HomeScreen()),
          ),
        ],
        showActions: true,
        showSkipButton: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(CSizes.defaultSpace),
          child: Column(
            children: [
              GridLayout(
                itemCount: 4,
                itemBuilder: (_, index) => ProductCardVertical(product: controller.featuredProducts[index],),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

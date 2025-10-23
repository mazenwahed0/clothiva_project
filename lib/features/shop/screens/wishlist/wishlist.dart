import 'package:clothiva_project/common/widgets/appbar/appbar.dart';
import 'package:clothiva_project/common/widgets/icons/circular_icon.dart';
import 'package:clothiva_project/common/widgets/layouts/grid_layout.dart';
import 'package:clothiva_project/common/widgets/loaders/animation_loader.dart';
import 'package:clothiva_project/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:clothiva_project/features/shop/controllers/product/favourites_controller.dart';
import 'package:clothiva_project/features/shop/controllers/product/product_controller.dart';
import 'package:clothiva_project/features/shop/models/product_model.dart';
import 'package:clothiva_project/features/shop/screens/home/home.dart';
import 'package:clothiva_project/navigation_menu.dart';
import 'package:clothiva_project/utils/constants/image_strings.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:clothiva_project/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=FavouritesController.instance;
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
          child: Obx(()=>FutureBuilder(
              future: controller.favouriteProducts(),
              builder: (context,snapshot){

                final emptyWidget=CAnimationLoaderWidget(
                  text: 'Whoops! Wishlist is Empty',
                  animation: CImages.clothIcon,
                  showAction: true,
                  onActionPressed: ()=>Get.off(()=>NavigationMenu()),
                );

                const loader=CVerticalProductShimmer(itemCount: 6,);
                final widget=TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader,nothingFound: emptyWidget);
                if(widget!=null) return widget;

                final products=snapshot.data!;
                return GridLayout(
                  itemCount: products.length,
                  itemBuilder: (_, index) => ProductCardVertical(product: products[index],),
                );
              }))
        ),
      ),
    );
  }
}

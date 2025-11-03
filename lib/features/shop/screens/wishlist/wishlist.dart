import 'package:clothiva_project/common/widgets/appbar/appbar.dart';
import 'package:clothiva_project/common/widgets/icons/circular_icon.dart';
import 'package:clothiva_project/common/widgets/layouts/grid_layout.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../invitation/screens/invitation_screen.dart';
import '../../controllers/products/favourites_controller.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favController = FavouritesController.instance;

    return Scaffold(
      appBar: CAppBar(
        title: Obx(
          () => Text(
            favController.isSharedMode.value ? 'Shared Wishlist' : 'Wishlist',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        actions: [
          CircularIcon(
            icon: Iconsax.user_add,
            onPressed: () => Get.to(() => const InvitationScreen()),
          ),
        ],
        showActions: true,
        showSkipButton: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(CSizes.defaultSpace),
              child: Obx(() {
                final productIds = favController.favourites.keys.toList();

                if (productIds.isEmpty) {
                  return CAnimationLoaderWidget(
                    text: favController.isSharedMode.value
                        ? 'No shared items yet.'
                        : 'Whoops! Wishlist is Empty.',
                    actionText: "Let's fill it",
                    animation: favController.isSharedMode.value
                        ? CImages.invitationPage
                        : CImages.whishlistPage,
                    showAction: true,
                    onActionPressed: () => Get.off(() => NavigationMenu()),
                  );
                }

                return FutureBuilder(
                  future: favController.favouriteProducts(),
                  builder: (context, snapshot) {
                    const loader = CVerticalProductShimmer(itemCount: 6);
                    final widget = CloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot,
                      loader: loader,
                      nothingFound: const SizedBox.shrink(),
                    );
                    if (widget != null) return widget;

                    final products = snapshot.data!;
                    return GridLayout(
                      itemCount: products.length,
                      itemBuilder: (_, index) =>
                          ProductCardVertical(product: products[index]),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

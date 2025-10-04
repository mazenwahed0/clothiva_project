import 'package:clothiva_project/features/shop/screens/promo_slider.dart';
import 'package:clothiva_project/utils/helpers/exports.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:clothiva_project/utils/constants/colors.dart';
import '../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../common/widgets/images/rounded_image.dart';
import '../../../../common/widgets/layouts/grid_layout.dart'; // تحتاج إلى هذه الإضافة
import '../../../../common/widgets/products.cart/cart_menu_icon.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../common/widgets/products/product_cart_vertical.dart';
import 'home_appbar.dart';
import 'home_categories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  /// Appbar
                  const THomeAppBar(),
                  const SizedBox(height: CSizes.spaceBtSections),

                  /// Searchbar
                  const SearchContainer(text: 'Search in Store'),
                  const SizedBox(height: CSizes.spaceBtSections),

                  /// Categories
                  Padding(
                    padding: const EdgeInsets.only(left: CSizes.defaultSpace),
                    child: Column(
                      children: [
                        ///Heading
                        SectionHeading(
                            title: 'Popular Categories',
                            showActionButton: false),
                        const SizedBox(height: CSizes.spaceBtItems),

                        /// Categories
                        CHomeCategories(),
                      ],
                    ),
                  ),
                  const SizedBox(height: CSizes.spaceBtSections),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(CSizes.defaultSpace),
              child: Column(
                children: [
                  /// Promo Slider
                  CPromoSlider(
                    banners: [
                      CImages.promoBanner1,
                      CImages.promoBanner2,
                      CImages.promoBanner3,
                    ],
                  ),
                  const SizedBox(height: CSizes.spaceBtSections),

                  /// Popular Products Heading
                  SectionHeading(title: 'Popular Products', onPressed: () {}),
                  const SizedBox(height: CSizes.spaceBtItems),

                  /// Popular Products Grid
                  GridLayout(itemCount: 4, itemBuilder: (_, index) => const TProductCardVertical()),
                ],
              ),
            ) // Padding
          ],
        ),
      ),
    );
  }
}














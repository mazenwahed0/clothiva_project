import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clothiva_project/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:clothiva_project/common/widgets/layouts/grid_layout.dart';
import 'package:clothiva_project/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:clothiva_project/utils/constants/colors.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../controllers/product_controller.dart';
import 'widgets/home_appbar.dart';
import 'widgets/home_categories.dart';
import 'widgets/promo_slider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final user = FirebaseAuth.instance.currentUser;
  final authService = AuthenticationRepository();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    // bool dark = context.isDarkMode || context.isDarkModeMedia;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// MARK:- Header
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  /// MARK:- Appbar
                  HomeAppBar(),

                  /// MARK:- Searchbar
                  SearchContainer(text: 'Search in Store'),
                  SizedBox(height: CSizes.spaceBtSections),

                  /// MARK:- Categories
                  Padding(
                    padding: EdgeInsetsGeometry.only(left: CSizes.defaultSpace),
                    child: Column(
                      children: [
                        /// -- Heading
                        SectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: CColors.white,
                        ),
                        SizedBox(height: CSizes.spaceBtItems),

                        /// -- Categories
                        HomeCategories(),
                      ],
                    ),
                  ),
                  SizedBox(height: CSizes.spaceBtSections),
                ],
              ),
            ),

            /// Mark:- Body
            Padding(
              padding: const EdgeInsets.all(CSizes.defaultSpace),
              child: Column(
                children: [
                  /// -- Promo Slider
                  PromoSlider(),
                  SizedBox(height: CSizes.spaceBtSections),

                  /// -- Popular Products (Gridview)
                  SectionHeading(
                    title: 'Products Flash Sale',
                    onPressed: () {},
                    showActionButton: true,
                  ),
                  SizedBox(height: CSizes.spaceBtItems),

                  /// -- Gridview Products
                  GridLayout(
                    itemCount: 4,
                    itemBuilder: (_, index) => ProductCardVertical(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

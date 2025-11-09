import 'package:clothiva_project/common/widgets/appbar/appbar.dart';
import 'package:clothiva_project/common/widgets/layouts/grid_layout.dart';
import 'package:clothiva_project/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:clothiva_project/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:clothiva_project/common/widgets/texts/section_heading.dart';
import 'package:clothiva_project/features/shop/controllers/category_controller.dart';
import 'package:clothiva_project/features/shop/screens/sub_categories/sub_categories.dart';
import 'package:clothiva_project/utils/constants/colors.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/image_text/image_text_vertical.dart';
import '../all_products/all_products.dart';
import '../../controllers/search_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = CSearchController.instance;
    final categoryController = CategoryController.instance;
    final bool dark = context.isDarkMode;

    return Scaffold(
      appBar: CAppBar(
        showBackArrow: true,
        showActions: false,
        showSkipButton: false,
        title: TextFormField(
          controller: searchController.searchBarController,
          autofocus: false,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: 'Search in Store...',
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            prefixIcon: Icon(
              Iconsax.search_normal,
              color: dark ? CColors.white : CColors.dark,
            ),
            suffixIcon: Obx(
              () => searchController.isSearching.value
                  ? IconButton(
                      icon: Icon(
                        Iconsax.close_circle,
                        color: dark ? CColors.white : CColors.dark,
                      ),
                      onPressed: () => searchController.clearSearch(),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Obx(() {
            // If not searching, show categories
            if (!searchController.isSearching.value) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeading(
                    title: 'All Categories',
                    showActionButton: false,
                  ),
                  const SizedBox(height: CSizes.spaceBtItems),
                  GridLayout(
                    itemCount: categoryController.allCategories.length,
                    mainAxisExtent: 100, // Adjust height for category
                    itemBuilder: (_, index) {
                      final category = categoryController.allCategories[index];
                      return VerticalImageAndText(
                        image: category.image,
                        backgroundColor: dark
                            ? CColors.black
                            : const Color.fromARGB(255, 231, 229, 225),
                        title: category.name,
                        textColor: dark ? CColors.white : CColors.dark,
                        onTap: () {
                          // Check if the tapped category is a PARENT category
                          if (category.parentId.isEmpty) {
                            // If it's a parent, go to the SubCategoriesScreen
                            Get.to(
                              () => SubCategoriesScreen(category: category),
                            );
                          } else {
                            // If it's a SUB-category, go directly to the AllProducts screen
                            Get.to(
                              () => AllProducts(
                                title: category.name,
                                // Pass the future method to load products for this specific category
                                futureMethod: categoryController
                                    .getCategoryProducts(
                                      categoryId: category.id,
                                      limit: -1, // -1 means get all products
                                    ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              );
            }
            // If searching and loading, show shimmer
            else if (searchController.isLoading.value) {
              return const CVerticalProductShimmer();
            }
            // If searching and no results, show message
            else if (searchController.searchResults.isEmpty) {
              return const Center(
                child: Text('No products found for your search.'),
              );
            }
            // If searching and have results, show products
            else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeading(
                    title: 'Search Results',
                    showActionButton: false,
                  ),
                  const SizedBox(height: CSizes.spaceBtItems),
                  GridLayout(
                    itemCount: searchController.searchResults.length,
                    itemBuilder: (_, index) {
                      final product = searchController.searchResults[index];
                      return ProductCardVertical(product: product);
                    },
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}

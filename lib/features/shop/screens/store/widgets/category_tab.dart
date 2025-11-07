import 'package:clothiva_project/features/shop/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../../common/widgets/texts/section_heading.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../controllers/category_controller.dart';
import '../../all_products/all_products.dart';
import 'category_brands.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              /// Brands
              // Two instances of Brand Showcases are displayed
              CategoryBrands(category: category),
              const SizedBox(height: CSizes.spaceBtItems),

              const SizedBox(height: CSizes.spaceBtItems),

              /// Products
              FutureBuilder(
                future: controller.getCategoryProducts(categoryId: category.id),
                builder: (context, snapshot) {
                  final response = CloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: CVerticalProductShimmer(),
                  );
                  if (response != null) return response;

                  final products = snapshot.data!;
                  return Column(
                    children: [
                      SectionHeading(
                        title: 'You might like',
                        onPressed: () => Get.to(
                          () => AllProducts(
                            title: category.name,
                            futureMethod: controller.getCategoryProducts(
                              categoryId: category.id,
                              limit: -1,
                            ),
                          ),
                        ),
                      ),
                      GridLayout(
                        itemCount: products.length,
                        itemBuilder: (_, index) =>
                            ProductCardVertical(product: products[index]),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: CSizes.spaceBtItems),
            ],
          ),
        ),
      ],
    );
  }
}

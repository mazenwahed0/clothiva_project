import 'package:clothiva_project/features/shop/controllers/product/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/widgets/brands/brand_show_case.dart';
import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../models/category_model.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(ProductController());
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
              CBrandShowcase(
                images: [
                  CImages.productImage19a,
                  CImages.productImage24,
                  CImages.productImage4,
                ],
              ),
              const CBrandShowcase(
                images: [
                  CImages.productImage4a,
                  CImages.productImage4b,
                  CImages.productImage4c,
                ],
              ),

              const SizedBox(height: CSizes.spaceBtItems),

              /// Products
              SectionHeading(title: 'You might like', onPressed: () {}),
              const SizedBox(height: CSizes.spaceBtItems),

              GridLayout(
                itemCount: 4,
                itemBuilder: (_, index) =>ProductCardVertical(product: controller.featuredProducts[index],),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../../common/widgets/brands/brand_show_case.dart';
import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/product_cart_vertical.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
 // TSizes

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              // /// Brands
              // Two instances of TBrandShowcase are displayed
              CBrandShowcase(
                images: [
                  CImages.productImage23,
                  CImages.productImage22,
                  CImages.productImage1,
                ],
              ),
              const CBrandShowcase(
                images: [
                  CImages.productImage23,
                  CImages.productImage22,
                  CImages.productImage1,
                ],
              ),

              const SizedBox(height: CSizes.spaceBtItems),

              // /// Products
              SectionHeading(title: 'You might like', onPressed: () {}),
              const SizedBox(height: CSizes.spaceBtItems),

              GridLayout(
                itemCount: 4,
                itemBuilder: (_, index) => const TProductCardVertical(),
              ),

              const SizedBox(height: CSizes.spaceBtSections),

              // ... potentially more content below (not shown in the visible code)
            ],
          ), // Column
        ), // Padding
      ],
    ); // ListView
  }
}
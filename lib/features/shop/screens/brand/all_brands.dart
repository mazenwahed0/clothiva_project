import 'package:clothiva_project/common/widgets/appbar/appbar.dart';
import 'package:clothiva_project/common/widgets/brands/brand_card.dart';
import 'package:clothiva_project/common/widgets/layouts/grid_layout.dart';
import 'package:clothiva_project/common/widgets/texts/section_heading.dart';
import 'package:clothiva_project/features/shop/controllers/brand_controller.dart';
import 'package:clothiva_project/features/shop/screens/brand/brand_products.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/shimmers/brands_shimmer.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;

    return Scaffold(
      appBar: CAppBar(
        title: Text('Brand'),
        showBackArrow: true,
        showActions: false,
        showSkipButton: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(CSizes.defaultSpace),
          child: Column(
            children: [
              /// Heading
              SectionHeading(title: 'Brands', showActionButton: false),
              SizedBox(height: CSizes.spaceBtItems),

              /// --- Brands Grid
              Obx(() {
                if (brandController.isLoading.value)
                  return const CBrandsShimmer();

                if (brandController.allBrands.isEmpty) {
                  return Center(
                    child: Text(
                      'No Data Found!',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.apply(color: Colors.white),
                    ),
                  );
                }

                return GridLayout(
                  itemCount: brandController.allBrands.length,
                  mainAxisExtent: 80,
                  itemBuilder: (_, index) {
                    // -- Passing Each Brand & onPress Event from Backend
                    final brand = brandController.allBrands[index];
                    return CBrandCard(
                      showBorder: true,
                      brand: brand,
                      onTap: () => Get.to(() => BrandProducts(brand: brand)),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

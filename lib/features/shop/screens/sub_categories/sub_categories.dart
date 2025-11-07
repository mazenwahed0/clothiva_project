import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/product_cards/product_card_horizontal.dart';
import '../../../../common/widgets/shimmers/horizontal_product_shimmer.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/category_controller.dart';
import '../../models/category_model.dart';
import '../all_products/all_products.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: CAppBar(
        showActions: false,
        showSkipButton: false,
        showBackArrow: true,
        title: Text(category.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              /// Sub-Categories
              FutureBuilder(
                future: controller.getSubCategory(category.id),
                builder: (context, snapshot) {
                  const loader = CHorizontalProductShimmer();
                  final widget = CloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: loader,
                  );

                  if (widget != null) return widget;

                  final subCategories = snapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: subCategories.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final subCategory = subCategories[index];
                      return FutureBuilder(
                        future: controller.getCategoryProducts(
                          categoryId: subCategory.id,
                        ),
                        builder: (context, snapshot) {
                          final widget =
                              CloudHelperFunctions.checkMultiRecordState(
                                snapshot: snapshot,
                                loader: loader,
                              );

                          if (widget != null) return widget;

                          final products = snapshot.data!;
                          return Column(
                            children: [
                              //Heading
                              SectionHeading(
                                title: subCategory.name,
                                onPressed: () => Get.to(
                                  () => AllProducts(
                                    title: subCategory.name,
                                    futureMethod: controller
                                        .getCategoryProducts(
                                          categoryId: subCategory.id,
                                          limit: -1,
                                        ),
                                  ),
                                ),
                              ),
                              SizedBox(height: CSizes.spaceBtItems / 2),

                              /// Thumbnail Image
                              SizedBox(
                                height: 120,
                                child: ListView.separated(
                                  itemCount: products.length,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        width: CSizes.spaceBtItems,
                                      ),
                                  itemBuilder: (context, index) =>
                                      ProductCardHorizontal(
                                        product: products[index],
                                      ),
                                ),
                              ),
                              const SizedBox(height: CSizes.spaceBtItems),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

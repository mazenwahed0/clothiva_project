import 'package:clothiva_project/common/widgets/shimmers/category_shimmer.dart';
import 'package:clothiva_project/features/shop/controllers/category_controller.dart';
import 'package:clothiva_project/features/shop/screens/sub_categories/sub_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/image_text/image_text_vertical.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Obx(() {
      if (categoryController.isLoading.value) return CCategoryShimmer();

      if (categoryController.featuredCategories.isEmpty) {
        return Center(
          child: Text(
            'No Data Found!',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.apply(color: Colors.white),
          ),
        );
      }
      return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categoryController.featuredCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = categoryController.featuredCategories[index];
            return VerticalImageAndText(
              image: category.image,
              title: category.name,
              onTap: () => Get.to(SubCategoriesScreen()), // -- SubCategoriesScreen Here
            );
          },
        ),
      );
    });
  }
}

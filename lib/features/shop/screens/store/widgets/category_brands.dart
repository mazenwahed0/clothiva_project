import 'package:flutter/cupertino.dart';

import '../../../../../common/widgets/brands/brand_show_case.dart';
import '../../../../../common/widgets/shimmers/boxes_shimmer.dart';
import '../../../../../common/widgets/shimmers/list_tile_shimmer.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../controllers/brand_controller.dart';
import '../../../models/category_model.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;

    return FutureBuilder(
      future: controller.getBrandsForCategory(category.id),
      builder: (context, snapshot) {
        const loader = Column(
          children: [
            CListTileShimmer(),
            SizedBox(height: CSizes.spaceBtSections),
            CBoxesShimmer(),
            SizedBox(height: CSizes.spaceBtSections),
          ],
        );

        final widget = CloudHelperFunctions.checkMultiRecordState(
          snapshot: snapshot,
          loader: loader,
        );
        if (widget != null) return widget;

        final brands = snapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: brands.length,
          itemBuilder: (_, index) {
            final brand = brands[index];
            return FutureBuilder(
                future:
                    controller.getBrandProducts(brandId: brand.id, limit: 3),
                builder: (context, snapshot) {
                  final widget = CloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;

                  final products = snapshot.data!;

                  return CBrandShowcase(
                    images: products.map((e) => e.thumbnail).toList(),
                    brand: brand,
                  );
                });
          },
        );
      },
    );
  }
}

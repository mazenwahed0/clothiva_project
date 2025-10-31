import 'package:clothiva_project/common/widgets/images/circular_image.dart';
import 'package:clothiva_project/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:clothiva_project/common/widgets/texts/product_price_text.dart';
import 'package:clothiva_project/common/widgets/texts/product_title_text.dart';
import 'package:clothiva_project/utils/constants/enums.dart';
import 'package:clothiva_project/utils/constants/image_strings.dart';
import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/products/product_controller.dart';
import '../../../models/product_model.dart';

class CProductMetaData extends StatelessWidget {
  const CProductMetaData({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = controller.CalculateSalePercentage(
      product.price,
      product.salePrice,
    );
    bool dark = context.isDarkMode || context.isDarkModeMedia;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            /// Sale Tag
            if (salePercentage != null)
              Row(
                children: [
                  RoundedContainer(
                    radius: CSizes.sm,
                    backgroundColor: CColors.secondary.withValues(alpha: 0.9),
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: CSizes.sm,
                      vertical: CSizes.xs,
                    ),
                    child: Text(
                      '$salePercentage%',
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge!.apply(color: CColors.black),
                    ),
                  ),
                  SizedBox(width: CSizes.spaceBtItems),
                ],
              ),

            /// Price
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              Text(
                '\$${product.price}',
                style: Theme.of(context).textTheme.titleSmall!.apply(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              const SizedBox(width: CSizes.spaceBtItems),
            ProductPriceText(
              price: controller.getProductPrice(product),
              isLarge: true,
            ),
          ],
        ),
        SizedBox(width: CSizes.spaceBtItems / 1.5),

        /// Title
        ProductTitleText(title: product.title),
        SizedBox(width: CSizes.spaceBtItems / 1.5),

        /// Stock Status
        Row(
          children: [
            ProductTitleText(title: 'Stock:'),
            SizedBox(width: CSizes.spaceBtItems),
            Text(
              controller.getProductStockStatus(product.stock),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),

        SizedBox(width: CSizes.spaceBtItems / 1.5),

        /// Brand
        Row(
          children: [
            CircularImage(
              image: product.brand != null ? product.brand!.image : '',
              width: 32,
              height: 32,
              overlayColor: dark ? CColors.white : CColors.black,
            ),
            BrandTitleWithVerifiedIcon(
              title: product.brand != null ? product.brand!.name : '',
              brandTextSize: TextSizes.medium,
            ),
          ],
        ),
      ],
    );
  }
}

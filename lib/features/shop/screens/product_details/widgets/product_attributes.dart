import 'package:clothiva_project/common/widgets/chips/rounded_choice_chips.dart';
import 'package:clothiva_project/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:clothiva_project/common/widgets/texts/product_title_text.dart';
import 'package:clothiva_project/common/widgets/texts/section_heading.dart';
import 'package:clothiva_project/features/shop/screens/product_details/widgets/attribute_widget.dart';
import 'package:clothiva_project/utils/constants/colors.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../controllers/products/variation_controller.dart';
import '../../../models/product_model.dart';

class CProductAttributes extends StatelessWidget {
  const CProductAttributes({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = VariationController.instance;
    bool dark = context.isDarkMode || context.isDarkModeMedia;
    return Obx(
      () => Column(
        children: [
          /// -- Selected Attribute Pricing & Description
          // Display variation price and stock when some variation is selected.
          if (controller.selectedVariation.value.id.isNotEmpty)
            RoundedContainer(
              padding: EdgeInsetsGeometry.all(CSizes.md),
              backgroundColor: dark ? CColors.darkerGrey : CColors.grey,
              child: Column(
                children: [
                  /// Title, Price and Stock Status
                  Row(
                    children: [
                      SectionHeading(
                        title: 'Variation',
                        showActionButton: false,
                      ),
                      SizedBox(width: CSizes.spaceBtItems),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ProductTitleText(
                                title: 'Price:',
                                smallSize: true,
                              ),
                              SizedBox(width: CSizes.spaceBtItems / 2),

                              /// Actual Price
                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                Text(
                                  "\$${controller.selectedVariation.value.price}",
                                  style: Theme.of(context).textTheme.titleSmall!
                                      .apply(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                ),
                              SizedBox(width: CSizes.spaceBtItems),

                              /// Sale Price
                              ProductPriceText(
                                price: controller.getVariationPrice(),
                              ),
                            ],
                          ),

                          /// Stock
                          Row(
                            children: [
                              ProductTitleText(
                                title: 'Stock:',
                                smallSize: true,
                              ),
                              SizedBox(width: CSizes.spaceBtItems / 2),
                              Text(
                                controller.variationStockStatus.value,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: CSizes.spaceBtItems / 2),

                  /// Variation Description
                  ProductTitleText(
                    title: controller.selectedVariation.value.description ?? '',
                    smallSize: true,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          SizedBox(height: CSizes.spaceBtItems),

          /// -- Attributes (Colors, Sizes (UK or European.. 32, 34) or any Attribute the Admin will add it'll be fetched via Firestore Database)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map(
                  (attribute) => Column(
                    // attribute = Product Single Attribute [Name: Color, Values: [Green, Blue, Orange]]
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeading(
                        title: attribute.name ?? '',
                        showActionButton: false,
                      ),
                      const SizedBox(height: CSizes.spaceBtItems / 2),
                      Obx(
                        () => Wrap(
                          spacing: 8,
                          children: attribute.values!.map((attributeValue) {
                            // attributeValue = Single Attribute Value [Green]
                            final isSelected =
                                controller.selectedAttributes[attribute.name] ==
                                attributeValue;
                            final available = controller
                                .getAttributesAvailabilityInVariation(
                                  product.productVariations!,
                                  attribute.name!,
                                )
                                .contains(attributeValue);

                            /// Attribute Chip
                            return CChoiceChip(
                              text: attributeValue,
                              selected: isSelected,
                              onSelected: available
                                  ? (selected) {
                                      if (selected && available) {
                                        controller.onAttributeSelected(
                                          product,
                                          attribute.name ?? '',
                                          attributeValue,
                                        );
                                      }
                                    }
                                  : null,
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: CSizes.spaceBtItems),
                    ],
                  ),
                )
                .toList(),
          ),
          // Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: product.productAttributes!
          //         .map((attribute) => Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 SectionHeading(
          //                   title: attribute.name ?? '',
          //                   showActionButton: false,
          //                 ),
          //                 SizedBox(
          //                   height: CSizes.spaceBtItems / 2,
          //                 ),
          //                 Obx(() => Wrap(
          //                     spacing: 8,
          //                     children: attribute.values!.map((attributeValue) {
          //                       final isSelected = controller
          //                               .selectedAttributes[attribute.name] ==
          //                           attributeValue;
          //                       final available = controller
          //                           .getAttributesAvailabilityInVariation(
          //                               product.productVariations!,
          //                               attribute.name!)
          //                           .contains(attributeValue);
          //                       return CChoiceChip(
          //                           text: attributeValue,
          //                           selected: isSelected,
          //                           onSelected: available
          //                               ? (selected) {
          //                                   if (selected && available) {
          //                                     controller
          //                                         .onAttributesAvailabilityInVariation(
          //                                             product,
          //                                             attribute.name ?? '',
          //                                             attributeValue);
          //                                   }
          //                                 }
          //                               : null);
          //                     }).toList()))
          //               ],
          //             ))
          //         .toList()),

          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     SectionHeading(
          //       title: 'Sizes',
          //       showActionButton: false,
          //     ),
          //     SizedBox(height: CSizes.spaceBtItems / 2),
          //     Wrap(
          //       spacing: 8,
          //       children: [
          //         CChoiceChip(
          //           text: 'EU 34',
          //           selected: true,
          //           onSelected: (value) {},
          //         ),
          //         CChoiceChip(
          //           text: 'EU 36',
          //           selected: false,
          //           onSelected: (value) {},
          //         ),
          //       ],
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}

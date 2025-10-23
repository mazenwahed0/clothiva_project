import 'package:clothiva_project/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:clothiva_project/common/widgets/texts/product_price_text.dart';
import 'package:clothiva_project/common/widgets/texts/product_title_text.dart';
import 'package:clothiva_project/common/widgets/texts/section_heading.dart';
import 'package:clothiva_project/features/shop/models/product_model.dart';
import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/chips/rounded_choice_chips.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/variation_controller.dart';

class CProdutAttributes extends StatelessWidget {
  const CProdutAttributes({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller=Get.put(VariationController());
    final dark = context.isDarkMode || context.isDarkModeMedia;
    return Obx(()=>
        Column(
          children: [
            if(controller.selectedVariation.value.id.isNotEmpty)
              RoundedContainer(
                backgroundColor: dark ? CColors.darkerGrey : CColors.grey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SectionHeading(title: "Variation", showActionButton: false),
                        SizedBox(width: CSizes.spaceBtItems),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const ProductTitleText(
                                  title: 'Price',
                                  smallSize: true,
                                ),
                                if(controller.selectedVariation.value.salePrice>0)
                                  Text(
                                    "\$${controller.selectedVariation.value.price}",
                                    style: Theme.of(context).textTheme.titleSmall!
                                        .apply(decoration: TextDecoration.lineThrough),
                                  ),

                                const SizedBox(width: CSizes.spaceBtItems),

                                ProductPriceText(
                                  price: controller.getVariationPrice(),
                                ),
                                // Stock
                                Row(
                                  children: [
                                    const ProductTitleText(
                                      title: 'Stock',
                                      smallSize: true,
                                    ),
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
                      ],
                    ),

                    // Variation Description
                     ProductTitleText(
                      title: controller.selectedVariation.value.description??'',
                      smallSize: true,
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
            const SizedBox(height: CSizes.spaceBtItems),

            //Attributes
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                product.productAttributes!.map((attribute)=>
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeading(title: attribute.name??'',showActionButton: false,),
                        SizedBox(height: CSizes.spaceBtItems / 2,),
                        Obx(
                                ()=>Wrap(
                                spacing: 8,
                                children:
                                attribute.values!
                                    .map((attributeValue){
                                  final isSelected=controller.selectedAttributes[attribute.name]==attributeValue;
                                  final available=controller.getAttributesAvailabilityInVariation(product.productVariations!,attribute.name!).contains(attributeValue);
                                  return CChoiceChip(text: attributeValue, selected: isSelected, onSelected: available? (selected){
                                    if(selected&&available){
                                      controller.onAttributesAvailabilityInVariation(product, attribute.name??'', attributeValue);
                                    }
                                  }:null
                                  );
                                }
                                ).toList()
                            )
                        )
                      ],
                    )).toList()
            ),

          ],

        ));
    throw UnimplementedError();
  }
}


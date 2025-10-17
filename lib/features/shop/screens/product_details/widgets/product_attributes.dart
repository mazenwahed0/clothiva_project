import 'package:clothiva_project/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:clothiva_project/common/widgets/texts/product_price_text.dart';
import 'package:clothiva_project/common/widgets/texts/product_title_text.dart';
import 'package:clothiva_project/common/widgets/texts/section_heading.dart';
import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/chips/rounded_choice_chips.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class CProdutAttributes extends StatelessWidget {
  const CProdutAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = context.isDarkMode || context.isDarkModeMedia;
    return Column(
      children: [
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
                          Text(
                            "\$25",
                            style: Theme.of(context).textTheme.titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),

                          const SizedBox(width: CSizes.spaceBtItems),

                          // Stock
                          Row(
                            children: [
                              const ProductTitleText(
                                title: 'Stock',
                                smallSize: true,
                              ),
                              Text(
                                "In Stock",
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
              const ProductTitleText(
                title: "This is the description of the product",
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
          children: [
            SectionHeading(title: "Colors"),
            SizedBox(height: CSizes.spaceBtItems / 2,),
            Wrap(
              children: [
                CChoiceChip(text: "Red", selected: true, onSelected: (value){}),
                CChoiceChip(text: "Green", selected: false, onSelected: (value){}),
                CChoiceChip(text: "Blue", selected: false,onSelected: (value){}),
              ],
            ),
          ],
        ),


         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeading(title: "Size"),
            SizedBox(height: CSizes.spaceBtItems / 2,),
            Wrap(
              spacing: 8,
              children: [
                CChoiceChip(text: "EU 34", selected: true, onSelected: (value){}),
                CChoiceChip(text: "EU 36", selected: false, onSelected: (value){}),
                CChoiceChip(text: "EU 38", selected: false, onSelected: (value){}),
              ],
            ),
          ],
        ),
      ],
    );
    throw UnimplementedError();
  }
}


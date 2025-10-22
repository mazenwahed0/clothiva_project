import 'package:clothiva_project/common/widgets/appbar/appbar.dart';
import 'package:clothiva_project/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:clothiva_project/common/widgets/images/rounded_image.dart';
import 'package:clothiva_project/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:clothiva_project/common/widgets/texts/section_heading.dart';
import 'package:clothiva_project/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/icons/circular_icon.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class SubCategoriesScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        showActions: false,
        showSkipButton: false,
        showBackArrow: true,
        title: Text('Sport'),
      ),
      body: SingleChildScrollView(
        child:Padding(
          padding: EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              /// Runner
              RoundedImage(width: double.infinity, imageUrl: CImages.promoBanner3, applyImageRadius: true,),
              SizedBox(height: CSizes.spaceBtItems,),

              /// Sub-Categories
              Column(
                children: [
                  SectionHeading(title: "Sports shirts"),
                  SizedBox(height: CSizes.spaceBtItems / 2,),

                  /// Thumbnail Image
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => const SizedBox(width: CSizes.spaceBtItems,),
                        itemBuilder: (context, index) => const ProductCardHorizontal()
                    ),
                  ),
                ],
              ),
            ],
          ),

        ),
      ),
    );
  }
  
}
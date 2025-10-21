import 'package:clothiva_project/common/widgets/texts/section_heading.dart';
import 'package:clothiva_project/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:clothiva_project/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:clothiva_project/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import '../../../../utils/constants/enums.dart';
import '../../models/product_model.dart';
import '../product_reviews/product_reviews.dart';
import 'widgets/product_detail_image_slider.dart';
import '../../../../../utils/constants/sizes.dart';
import 'widgets/rating_share.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    bool dark = context.isDarkMode || context.isDarkModeMedia;
    return Scaffold(
      bottomNavigationBar: CBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Image Slider
            CProductImageSlider(product: product,),

            // Product Details
            Padding(
              padding: EdgeInsets.only(
                left: CSizes.defaultSpace,
                right: CSizes.defaultSpace,
                top: CSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  // Ratings and Share button
                  CRatingAndShare(),

                  //price, title
                  CProductMetaData(product: product,),

                  //Attributes
                  if(product.productType==ProductType.variable.toString())
                  CProdutAttributes(product: product,),
                  if(product.productType==ProductType.variable.toString())
                  SizedBox(height: CSizes.spaceBtItems,),

                  // Checkout Button
                  SizedBox(width: double.infinity,child: ElevatedButton(onPressed: (){}, child: Text("Checkout"))),

                  // Description
                  const SectionHeading(title: "Description", showActionButton: false),
                  const SizedBox(height: CSizes.spaceBtItems),
                  ReadMoreText(
                    product.description??'',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  // Reviews
                  const Divider(),
                  const SizedBox(height: CSizes.spaceBtItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SectionHeading(title: "Reviews(199)", showActionButton: false,),
                      IconButton(onPressed: () => Get.to(() => ProductReviewsScreen()), icon: const Icon(Iconsax.arrow_right_3, size: 18,)),

                    ],
                  ),
                  const SizedBox(height: CSizes.spaceBtItems),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




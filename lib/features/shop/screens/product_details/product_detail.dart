import 'package:clothiva_project/common/widgets/texts/section_heading.dart';
import 'package:clothiva_project/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:clothiva_project/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:clothiva_project/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import '../../../../utils/constants/enums.dart';
import '../../models/product_model.dart';
import 'widgets/product_detail_image_slider.dart';
import 'widgets/rating_share_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CBottomAddToCart(product: product),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// MARK: 1- Product Image & Slider
            CProductImageSlider(product: product),

            /// MARK: 2- Product Details
            Padding(
              padding: EdgeInsetsGeometry.only(
                right: CSizes.defaultSpace,
                left: CSizes.defaultSpace,
                bottom: CSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  /// - Rating & Share Button
                  CRatingAndShare(),

                  /// - Price, Title, Stock & Brand
                  CProductMetaData(product: product),

                  /// -- Attributes
                  if (product.productType == ProductType.variable.toString())
                    CProductAttributes(product: product),
                  if (product.productType == ProductType.variable.toString())
                    SizedBox(height: CSizes.spaceBtSections),

                  /// - Description
                  SectionHeading(title: 'Description', showActionButton: false),
                  SizedBox(height: CSizes.spaceBtItems),
                  ReadMoreText(
                    product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Show less',
                    moreStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                    lessStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  /// - Reviews
                  Divider(),
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

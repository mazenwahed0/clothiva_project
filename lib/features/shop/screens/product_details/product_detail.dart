import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/product_detail_image_slider.dart';
import '../../../../../utils/constants/sizes.dart';
import 'widgets/rating_share.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});
  @override
  Widget build(BuildContext context) {
    bool dark = context.isDarkMode || context.isDarkModeMedia;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Image Slider
            CProductImageSlider(),

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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../utils/helpers/helper_functions.dart';
import 'widgets/product_detail_image_slider.dart';
import '../../../../../utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';
import 'widgets/rating_share.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});
  @override
  Widget build(BuildContext context) {
    final isDark = CHelperFunctions.isDarkMode(context);
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


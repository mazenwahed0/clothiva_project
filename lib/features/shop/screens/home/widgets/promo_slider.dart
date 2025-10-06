import 'package:carousel_slider/carousel_slider.dart';
import 'package:clothiva_project/common/widgets/shimmers/shimmer.dart';
import 'package:clothiva_project/features/shop/controllers/banner_controller.dart';
import 'package:clothiva_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../utils/constants/sizes.dart';

class PromoSlider extends StatelessWidget {
  const PromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(() {
      // Loader
      if (controller.isLoading.value) {
        return CShimmerEffect(width: double.infinity, height: 190);
      }

      if (controller.banners.isEmpty) {
        return Center(child: Text('No Data Found!'));
      } else {
        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                onPageChanged: (index, _) =>
                    controller.updatePageIndicator(index),
              ),
              items: controller.banners
                  .map(
                    (banner) => RoundedImage(
                      imageUrl: banner.imageUrl,
                      isNetworkImage: true,
                      onPressed: () => Get.toNamed(banner.targetScreen),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: CSizes.spaceBtItems),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < controller.banners.length; i++)
                    CircularContainer(
                      width: 20,
                      height: 4,
                      margin: EdgeInsets.only(right: 10),
                      backgroundColor:
                          controller.carouselCurrentindex.value == i
                          ? CColors.primary
                          : CColors.grey,
                    ),
                ],
              ),
            ),
          ],
        );
      }
    });
  }
}

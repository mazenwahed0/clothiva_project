import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../common/widgets/products/favourite_icon/favourite_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/products/image_controller.dart';
import '../../../models/product_model.dart';

class CProductImageSlider extends StatelessWidget {
  const CProductImageSlider({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImageController());
    final images = controller.getAllProductImages(product);
    final bool dark = context.isDarkMode;
    return CurvedEdgesWidget(
      child: Container(
        color: dark ? CColors.darkerGrey : CColors.lightContainer,
        child: Stack(
          children: [
            /// Note: First in the Stack, Bottom in UI
            /// Main Large Image
            Center(
              child: SizedBox(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(CSizes.productImageRadius * 2),
                  child: Obx(() {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargedImage(image),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder: (_, __, downloadProgress) =>
                            CircularProgressIndicator(
                              value: downloadProgress.progress,
                              color: CColors.primary,
                            ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            /// Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: CSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: CSizes.spaceBtItems),
                  itemCount: images.length,
                  itemBuilder: (_, index) => Obx(() {
                    final imageSelected =
                        controller.selectedProductImage.value == images[index];
                    return RoundedImage(
                      onPressed: () =>
                          controller.selectedProductImage.value = images[index],
                      width: 80,
                      isNetworkImage: true,
                      backgroundColor: dark ? CColors.dark : CColors.white,
                      border: Border.all(
                        color: imageSelected
                            ? CColors.primary
                            : Colors.transparent,
                      ),
                      padding: EdgeInsets.all(CSizes.sm),
                      imageUrl: images[index],
                    );
                  }),
                ),
              ),
            ),

            /// Appbar Icons
            CAppBar(
              showBackArrow: true,
              showActions: true,
              showSkipButton: false,
              actions: [FavouriteIcon(productId: product.id)],
            ),
          ],
        ),
      ),
    );
  }
}

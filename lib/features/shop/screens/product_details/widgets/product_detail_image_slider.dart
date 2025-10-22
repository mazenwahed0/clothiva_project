import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothiva_project/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:clothiva_project/features/shop/models/product_model.dart';
import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../controllers/product/image_controller.dart';

class CProductImageSlider extends StatelessWidget {
  const CProductImageSlider({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller= Get.put(ImageController());
    final images=controller.getAllProductImages(product);
    bool dark = context.isDarkMode || context.isDarkModeMedia;
    return CurvedEdgesWidget(
      child: Container(
        color: dark ? CColors.darkGrey : CColors.white, //no color named light
        child: Stack(
          children: [
             SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(CSizes.productImageRadius * 2),
                child: Center(
                  child: Obx((){
                    final image=controller.selectedProductImage.value;
                    return  GestureDetector(
                      onTap: ()=>controller.showEnlargedImage(image),
                      child: CachedNetworkImage(imageUrl: image,progressIndicatorBuilder: (_,__,downloadProgress)=>CircularProgressIndicator(value: downloadProgress.progress,color: CColors.primary,),),
                    );
                  }),
                ),
              ),
            ),

            //image slider
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
                  itemBuilder: (_, index) => Obx((){
                    final imageSelected=controller.selectedProductImage.value==images[index];
                    return RoundedImage(
                      onPressed: ()=> controller.selectedProductImage.value=images[index],
                      width: 80,
                      isNetworkImage: true,
                      backgroundColor: dark ? CColors.dark : CColors.white,
                      border: Border.all(color: imageSelected? CColors.primary:Colors.transparent),
                      padding: EdgeInsets.all(CSizes.sm),
                      imageUrl: images[index],
                    );
                  }),
                ),
              ),
            ),

            //Appbar Icons
             CAppBar(
              showBackArrow: true,
              actions: [FavouriteIcon(productId: product.id,)],
              showActions: false,
              showSkipButton: false,
            ),
          ],
        ),
      ),
    );
  }
}

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

class CProductImageSlider extends StatelessWidget {
  const CProductImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = context.isDarkMode || context.isDarkModeMedia;
    return CurvedEdgesWidget(
      child: Container(
        color: dark ? CColors.darkGrey : CColors.white, //no color named light
        child: Stack(
          children: [
            const SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(CSizes.productImageRadius * 2),
                child: Center(
                  child: Image(image: AssetImage(CImages.productImage19a)),
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
                  itemCount: 6,
                  itemBuilder: (_, index) => RoundedImage(
                    width: 80,
                    backgroundColor: dark ? CColors.dark : CColors.white,
                    border: Border.all(color: CColors.primary),
                    padding: EdgeInsets.all(CSizes.sm),
                    imageUrl: CImages.productImage64,
                  ),
                ),
              ),
            ),

            //Appbar Icons
            const CAppBar(
              showBackArrow: true,
              actions: [CircularIcon(icon: Iconsax.heart5, color: CColors.red)],
              showActions: false,
              showSkipButton: false,
            ),
          ],
        ),
      ),
    );
  }
}

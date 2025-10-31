import 'package:clothiva_project/utils/helpers/context_extensions.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../features/cart/models/cart_item_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../images/rounded_image.dart';
import '../../texts/brand_title_text_with_verified_icon.dart';
import '../../texts/product_title_text.dart';

class CCartItem extends StatelessWidget {
  const CCartItem({super.key, required this.cartItem});

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    bool dark = context.isDarkMode || context.isDarkModeMedia;

    return Row(
      children: [
        /// Image
        RoundedImage(
          imageUrl: cartItem.image ?? '',
          width: 60,
          height: 60,
          isNetworkImage: true,
          padding: const EdgeInsets.all(CSizes.sm),
          backgroundColor: dark ? CColors.darkerGrey : CColors.lightGrey,
        ),
        const SizedBox(width: CSizes.spaceBtItems),

        /// Title, Price & Size
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BrandTitleWithVerifiedIcon(title: cartItem.brandName ?? ''),
              ProductTitleText(title: cartItem.title!, maxLines: 1),
              Text.rich(
                TextSpan(
                  children: (cartItem.selectedVariation ?? {})
                      .entries
                      .map(
                        (e) => TextSpan(
                          children: [
                            TextSpan(
                              text: ' ${e.key} ',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            TextSpan(
                              text: ' ${e.value} ',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

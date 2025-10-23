import 'package:clothiva_project/common/widgets/products/rating/rating_indicator.dart';
import 'package:clothiva_project/utils/constants/enums.dart';
import 'package:clothiva_project/utils/constants/image_strings.dart';
import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class UserReviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dark = context.isDarkMode || context.isDarkModeMedia;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(backgroundImage: AssetImage(CImages.userProfileImage),),
                const SizedBox(width: CSizes.spaceBtItems,),
                Text('John Doe', style: Theme.of(context).textTheme.titleLarge,)
              ],
            ),
          ],
        ),
        const SizedBox(height: CSizes.spaceBtItems,),


        // Review
        Row(
          children: [
            CRatingIndicator(rating: 4),
            const SizedBox(width: CSizes.spaceBtItems,),
            Text('01 Nov, 2023', style: Theme.of(context).textTheme.titleLarge,)
          ],
        ),
        const SizedBox(height: CSizes.spaceBtItems,),
        ReadMoreText(
          'The user review The user review The user review The user review The user review The user review The user reviewThe user review The user review The user review',
          trimLines: 1,
          trimMode: TrimMode.Line,
          trimExpandedText: ' show less',
          trimCollapsedText: ' show more',
          moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:  CColors.primary),
          lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:  CColors.primary),
        ),
        const SizedBox(height: CSizes.spaceBtItems,),

        /// Company Review
        RoundedContainer(
          backgroundColor: dark ? CColors.darkerGrey : CColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(CSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('T`s Store', style: Theme.of(context).textTheme.titleMedium,),
                    Text('02 Nov, 2023', style: Theme.of(context).textTheme.titleLarge,),

                  ],
                ),
                const SizedBox(height: CSizes.spaceBtItems,),
                ReadMoreText(
                  'The user review The user review The user review The user review The user review The user review The user reviewThe user review The user review The user review',
                  trimLines: 1,
                  trimMode: TrimMode.Line,
                  trimExpandedText: ' show less',
                  trimCollapsedText: ' show more',
                  moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:  CColors.primary),
                  lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:  CColors.primary),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: CSizes.spaceBtItems,),
      ],
    );

  }

}
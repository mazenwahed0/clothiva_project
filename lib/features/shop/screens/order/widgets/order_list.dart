import 'package:clothiva_project/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:clothiva_project/utils/constants/colors.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class COrderList extends StatelessWidget {
  const COrderList({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = context.isDarkMode || context.isDarkModeMedia;

    return ListView.separated(
      shrinkWrap: true,
      itemCount: 10,
      separatorBuilder: (_, __) => const SizedBox(height: CSizes.spaceBtItems,),
      itemBuilder: (_, index) => RoundedContainer(
        showBorder: true,
        padding: EdgeInsets.all(CSizes.md),
        backgroundColor: dark ? CColors.dark : CColors.light,
        child: Column(
          children: [

            Row(
              children: [
                /// 1 - Icon
                Icon(Iconsax.ship, color: dark ? CColors.white : CColors.black),
                SizedBox(width: CSizes.spaceBtItems / 2),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Processing',
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                          color: CColors.primary,
                          fontWeightDelta: 1,
                        ),
                      ),
                      Text(
                        '18 Nov 2025',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
    
                /// 3 - Icon
                IconButton(onPressed: () {}, icon: Icon(Iconsax.arrow_right_34, size: CSizes.iconSm,))
              ],
            ),
            
            const SizedBox(height: CSizes.spaceBtItems,),
            

            Row( 
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    /// Icon
                    Icon(Iconsax.tag, color: dark ? CColors.white : CColors.black),
                    SizedBox(width: CSizes.spaceBtItems / 2),
    
                    /// Status
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Text(
                          '#256f2',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: CSizes.spaceBtItems / 2),

            Row( 
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ///Icon
                    Icon(Iconsax.calendar, color: dark ? CColors.white : CColors.black),
                    SizedBox(width: CSizes.spaceBtItems / 2),
    
                    ///Status
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shipping Date',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Text(
                          '18 Nov 2002',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
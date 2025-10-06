import 'shimmer.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/sizes.dart';
import '../layouts/grid_layout.dart';

class UVerticalProductShimmer extends StatelessWidget {
  const UVerticalProductShimmer({super.key, this.itemCount = 16});

  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return GridLayout(
      itemCount: itemCount,
      itemBuilder: (context, index) => const SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            CShimmerEffect(width: 180, height: 180),
            SizedBox(
              height: CSizes.spaceBtItems,
            ),

            /// Text
            CShimmerEffect(width: 160, height: 15),
            SizedBox(
              height: CSizes.spaceBtItems / 2,
            ),
            CShimmerEffect(width: 110, height: 15)
          ],
        ),
      ),
    );
  }
}

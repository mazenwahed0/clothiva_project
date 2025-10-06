import '../../../utils/constants/sizes.dart';
import 'shimmer.dart';
import 'package:flutter/material.dart';

class UHorizontalProductShimmer extends StatelessWidget {
  const UHorizontalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: CSizes.spaceBtSections),
      height: 120,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) =>
            SizedBox(width: CSizes.spaceBtItems),
        itemCount: itemCount,
        itemBuilder: (context, index) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Image
            CShimmerEffect(width: 120, height: 120),
            SizedBox(width: CSizes.spaceBtItems),

            /// Text
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: CSizes.spaceBtItems),

                    /// Title
                    CShimmerEffect(width: 160, height: 15),
                    SizedBox(height: CSizes.spaceBtItems / 2),

                    /// Brand
                    CShimmerEffect(width: 110, height: 15)
                  ],
                ),
                Row(
                  children: [
                    CShimmerEffect(width: 40, height: 20),
                    SizedBox(width: CSizes.spaceBtSections),
                    CShimmerEffect(width: 40, height: 20)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

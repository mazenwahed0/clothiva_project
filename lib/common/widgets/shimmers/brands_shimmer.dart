import 'shimmer.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class UBrandsShimmer extends StatelessWidget {
  const UBrandsShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) =>
          SizedBox(width: CSizes.spaceBtItems),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      itemBuilder: (context, index) => CShimmerEffect(
          width: CSizes.brandCardWidth, height: CSizes.brandCardHeight),
    );
  }
}

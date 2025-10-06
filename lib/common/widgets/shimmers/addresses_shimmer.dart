import 'shimmer.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class UAddressesShimmer extends StatelessWidget {
  const UAddressesShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) =>
            SizedBox(height: CSizes.spaceBtItems),
        itemCount: 4,
        itemBuilder: (context, index) =>
            CShimmerEffect(width: double.infinity, height: 150));
  }
}

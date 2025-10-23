import 'shimmer.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class CBoxesShimmer extends StatelessWidget {
  const CBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            /// Three Products
            Expanded(child: CShimmerEffect(width: 150, height: 110)),
            SizedBox(
              width: CSizes.spaceBtItems,
            ),
            Expanded(child: CShimmerEffect(width: 150, height: 110)),
            SizedBox(
              width: CSizes.spaceBtItems,
            ),
            Expanded(child: CShimmerEffect(width: 150, height: 110)),
          ],
        )
      ],
    );
  }
}

import '../layouts/grid_layout.dart';
import 'shimmer.dart';
import 'package:flutter/material.dart';

class CBrandsShimmer extends StatelessWidget {
  const CBrandsShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, __) => CShimmerEffect(width: 300, height: 80),
    );
  }
}

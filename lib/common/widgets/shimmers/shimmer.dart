import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/constants/colors.dart';

class CShimmerEffect extends StatelessWidget {
  const CShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.radius = 15,
    this.color,
  });

  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    // final dark = THelperFunctions.isDarkMode(context);
    bool dark = context.isDarkMode || context.isDarkModeMedia;
    return Shimmer.fromColors(
      baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? (dark ? CColors.darkerGrey : CColors.white),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

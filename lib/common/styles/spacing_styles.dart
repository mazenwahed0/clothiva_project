import '/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CSpacingStyle {
  static const EdgeInsetsGeometry PaddingWithAppbarHeight =
      EdgeInsetsGeometry.only(
    top: CSizes.appBarHeight,
    left: CSizes.defaultSpace,
    bottom: CSizes.defaultSpace,
    right: CSizes.defaultSpace,
  );
}

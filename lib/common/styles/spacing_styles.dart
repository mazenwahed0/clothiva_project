import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class CSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeightAuth = EdgeInsets.only(
    top: CSizes.appBarHeight,
    left: CSizes.defaultSpace,
    bottom: CSizes.defaultSpace,
    right: CSizes.defaultSpace,
  );
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    left: CSizes.defaultSpace,
    bottom: CSizes.defaultSpace / 2,
    right: CSizes.defaultSpace,
  );
  static const EdgeInsetsGeometry paddingWithDefaultWidth = EdgeInsets.only(
    left: CSizes.defaultSpace,
    right: CSizes.defaultSpace,
  );

  static const EdgeInsetsGeometry paddingOnlyVertical = EdgeInsets.symmetric(
    vertical: CSizes.defaultSpace,
  );

  static const EdgeInsetsGeometry paddingWithDefaultHeight = EdgeInsets.only(
    top: CSizes.defaultSpace,
    left: CSizes.defaultSpace,
    bottom: CSizes.defaultSpace,
    right: CSizes.defaultSpace,
  );
}

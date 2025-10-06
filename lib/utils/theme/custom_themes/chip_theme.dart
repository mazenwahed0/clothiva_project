import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class CChipTheme {
  CChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: CColors.grey.withValues(alpha: 0.4),
    labelStyle: TextStyle(color: Colors.black),
    selectedColor: CColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    checkmarkColor: CColors.white,
  );
  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: CColors.darkerGrey,
    labelStyle: TextStyle(color: CColors.white),
    selectedColor: CColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    checkmarkColor: CColors.white,
  );
}

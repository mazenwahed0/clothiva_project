import '/utils/theme/custom_themes/chip_theme.dart';
import 'package:flutter/material.dart';
import './custom_themes/bottom_sheet_theme.dart';
import './custom_themes/checkbox_theme.dart';
import './custom_themes/text_field_theme.dart';
import './custom_themes/outline_button_theme.dart';
import './custom_themes/elevated_button_theme.dart';
import './custom_themes/text_theme.dart';
import './custom_themes/appbar_theme.dart';

class CAppTheme {
  CAppTheme._(); //Private Constructor

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: CAppBarTheme.lightAppBarTheme,
    textTheme: CTextTheme.lightTextTheme,
    elevatedButtonTheme: CElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: COutlinedButtonTheme.lightOutlinedButtonTheme,
    checkboxTheme: CCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: CBottomSheetTheme.lightBottomSheetTheme,
    inputDecorationTheme: CTextFormFieldTheme.lightInputDecorationTheme,
    chipTheme: CChipTheme.lightChipTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: CAppBarTheme.darkAppBarTheme,
    textTheme: CTextTheme.darkTextTheme,
    elevatedButtonTheme: CElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: COutlinedButtonTheme.darkOutlinedButtonTheme,
    checkboxTheme: CCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: CBottomSheetTheme.darkBottomSheetTheme,
    inputDecorationTheme: CTextFormFieldTheme.darkInputDecorationTheme,
    chipTheme: CChipTheme.lightChipTheme,
  );
}

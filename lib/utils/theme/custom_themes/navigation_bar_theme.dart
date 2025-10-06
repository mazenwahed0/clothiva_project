import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class CNavigationBarTheme {
  CNavigationBarTheme._();

  /// Light Navigation Bar Theme
  static NavigationBarThemeData lightNavigationBarTheme =
      NavigationBarThemeData(
    backgroundColor: Colors.white,
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    indicatorColor: Colors.black12,
    labelTextStyle: WidgetStatePropertyAll(
      TextStyle(color: Colors.black),
    ),
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const IconThemeData(color: CColors.black);
      }
      return const IconThemeData(color: CColors.dark);
    }),
  );

  /// Dark Navigation Bar Theme
  static NavigationBarThemeData darkNavigationBarTheme = NavigationBarThemeData(
    backgroundColor: Colors.black,
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    indicatorColor: Colors.white12,
    labelTextStyle: WidgetStatePropertyAll(
      TextStyle(color: CColors.white),
    ),
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const IconThemeData(color: CColors.white);
      }
      return const IconThemeData(color: CColors.grey);
    }),
  );
}

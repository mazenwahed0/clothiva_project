import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/device/device_utility.dart';

class CTabBar extends StatelessWidget implements PreferredSizeWidget {
  /// If you want to add the background color to tabs you have to wrap them in Material widget.
  /// To do that we need [PreferredSized] Widget and that's why created custom class. [PreferredSizeWidget]

  const CTabBar({super.key, required this.tabs});

  // Property to hold the list of tabs
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    // Note: used for dark mode check
    bool dark = context.isDarkMode || context.isDarkModeMedia;

    return Material(
      // Conditionally set the background color based on dark mode
      color: dark ? CColors.black : CColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: CColors.primary,
        // Conditionally set the selected label color
        labelColor: dark ? CColors.white : CColors.primary,
        unselectedLabelColor: CColors.darkGrey,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(CDeviceUtils.getAppBarHeight());
}

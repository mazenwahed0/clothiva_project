import 'package:clothiva_project/features/personalization/screens/settings/settings.dart';
import 'package:clothiva_project/features/shop/screens/home/home.dart';
import 'package:clothiva_project/features/shop/screens/store/store.dart';
import 'package:clothiva_project/features/shop/screens/wishlist/wishlist.dart';
import 'package:clothiva_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    bool dark = context.isDarkMode;

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: dark ? CColors.black : Colors.white,
          indicatorColor: dark
              ? CColors.white.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final selectedIndex = 0.obs;

  final screens = [
    HomeScreen(),
    StoreScreen(),
    WishlistScreen(),
    SettingsScreen(),
  ];
}

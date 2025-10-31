import 'package:clothiva_project/common/widgets/appbar/appbar.dart';
import 'package:clothiva_project/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:clothiva_project/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:clothiva_project/common/widgets/texts/section_heading.dart';
import 'package:clothiva_project/features/personalization/screens/profile/profile.dart';
import 'package:clothiva_project/features/personalization/screens/settings/widgets/load_data.dart';
import 'package:clothiva_project/features/personalization/controllers/user_controller.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../utils/constants/colors.dart';
import '../../../cart/screens/cart/cart.dart';
import '../../../shop/screens/order/order.dart';
import '../address/address.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Mark:- Header
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  /// -- Appbar
                  CAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium!.apply(color: CColors.white),
                    ),
                    showActions: false,
                    showSkipButton: false,
                  ),

                  /// -- User Profile Card
                  UserProfileTile(
                    onPressed: () => Get.to(() => ProfileScreen()),
                  ),

                  SizedBox(height: CSizes.spaceBtSections),
                ],
              ),
            ),

            /// Mark:- Body
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: CSizes.defaultSpace,
                vertical: CSizes.sm,
              ),
              child: Column(
                children: [
                  /// -- Account Settings
                  SectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),
                  SizedBox(height: CSizes.spaceBtItems),
                  SettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subtitle: 'Set Shopping delivery address',
                    onTap: () => Get.to(() => UserAddressScreen()),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subtitle: 'Add, remove products and move to checkout',
                    onTap: () => Get.to(() => CartScreen()),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subtitle: 'In-progress and Completed Orders',
                    onTap: () => Get.to(() => OrderScreen()),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subtitle: 'Withdraw balance to registered bank account',
                    onTap: () {},
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'My Coupons',
                    subtitle: 'List of all the discounted coupons',
                    onTap: () {},
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subtitle: 'Set any kind of notification message',
                    onTap: () {},
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subtitle: 'Manage data usage and connected accounts',
                    onTap: () {},
                  ),

                  /// -- App Settings
                  SizedBox(height: CSizes.spaceBtSections),
                  SectionHeading(
                    title: 'App Settings',
                    showActionButton: false,
                  ),
                  SizedBox(height: CSizes.spaceBtItems),
                  SettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'Load Data',
                    subtitle: 'Upload data to your cloud Firebase',
                    onTap: () => Get.to(() => LoadData()),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subtitle: 'Set recommendation based on location',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subtitle: 'Search result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'HD Image Quality',
                    subtitle: 'Set image quality to be seen',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  /// -- Logout Button
                  SizedBox(height: CSizes.spaceBtSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () async {
                        controller.logout();
                        //Note: Get.offAll is for widgets only NO METHODS.
                        //This way whenever you logout, the user will be kept logged out until he log in again.
                        // await AuthenticationRepository.instance.logout();
                        //But this way whenever you logout, if the user restart the app he's logged in again automatically.
                        // Get.offAll(() => const LoginScreen());
                      },
                      child: Text('Logout'),
                    ),
                  ),
                  SizedBox(height: CSizes.spaceBtSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

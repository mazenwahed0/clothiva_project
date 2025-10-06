import 'package:clothiva_project/common/widgets/appbar/appbar.dart';
import 'package:clothiva_project/common/widgets/images/circular_image.dart';
import 'package:clothiva_project/common/widgets/shimmers/shimmer.dart';
import 'package:clothiva_project/common/widgets/texts/section_heading.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../controllers/user_controller.dart';
import '../../../../utils/constants/image_strings.dart';
import 'widgets/change_name.dart';
import 'widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: CAppBar(
        title: Text('Profile'),
        showBackArrow: true,
        showActions: false,
        showSkipButton: false,
      ),

      /// Mark:- Body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(CSizes.defaultSpace),
          child: Obx(
            () => Column(
              children: [
                /// -- Profile Picture
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Obx(() {
                        final networkImage =
                            controller.user.value.profilePicture;
                        final image = networkImage.isNotEmpty
                            ? networkImage
                            : CImages.user;
                        return controller.imageUploading.value
                            ? CShimmerEffect(width: 80, height: 80, radius: 80)
                            : CircularImage(
                                image: image,
                                width: 80,
                                height: 80,
                                isNetworkImage: networkImage.isNotEmpty,
                              );
                      }),
                      TextButton(
                        onPressed: () => controller.uploadUserProfilePicture(),
                        child: Text('Change Profile Picture'),
                      ),
                    ],
                  ),
                ),

                /// Mark:- Details
                SizedBox(height: CSizes.spaceBtItems / 2),
                Divider(),
                SizedBox(height: CSizes.spaceBtItems),

                /// Mark:- Heading Profile Info
                SectionHeading(
                  title: 'Profile Information',
                  showActionButton: false,
                ),
                SizedBox(height: CSizes.spaceBtItems),

                ProfileMenu(
                  title: 'Name',
                  value: controller.user.value.fullName,
                  isLoading: controller.profileLoading,
                  onPressed: () => Get.to(() => ChangeName()),
                ),

                ProfileMenu(
                  title: 'Username',
                  value: controller.user.value.username,
                  isLoading: controller.profileLoading,
                  onPressed: () {},
                ),

                SizedBox(height: CSizes.spaceBtItems / 2),
                Divider(),
                SizedBox(height: CSizes.spaceBtItems),

                /// Mark:- Heading Personal Info
                SectionHeading(
                  title: 'Personal Information',
                  showActionButton: false,
                ),
                SizedBox(height: CSizes.spaceBtItems),

                ProfileMenu(
                  title: 'User ID',
                  value: controller.user.value.id,
                  isLoading: controller.profileLoading,
                  icon: Iconsax.copy,
                  onPressed: () {},
                ),
                ProfileMenu(
                  title: 'Email',
                  value: controller.user.value.email,
                  isLoading: controller.profileLoading,
                  onPressed: () {},
                ),
                ProfileMenu(
                  title: 'Phone Number',
                  value: controller.user.value.phoneNumber,
                  isLoading: controller.profileLoading,
                  onPressed: () {},
                ),
                ProfileMenu(
                  title: 'Gender',
                  value: "Male",
                  isLoading: controller.profileLoading,
                  onPressed: () {},
                ),
                ProfileMenu(
                  title: 'Date of Birth',
                  value: "4 July, 2002",
                  isLoading: controller.profileLoading,
                  onPressed: () {},
                ),

                Divider(),
                SizedBox(height: CSizes.spaceBtItems),

                /// Mark:- Delete Account
                Center(
                  child: TextButton(
                    onPressed: () => controller.deleteAccountWarningPopup(),
                    child: Text(
                      'Close Account',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

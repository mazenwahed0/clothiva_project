import 'package:clothiva_project/data/repositories/user/user_repository.dart';
import 'package:clothiva_project/features/personalization/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// init user data when Home Screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  /// Fetch User Record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
        'We are updating your information...',
        CImages.docerAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        Loaders.customToast(message: 'No Internet Connection');
        return;
      }

      // Form Validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Update user's first & last name in the Firebase Firestore
      Map<String, dynamic> name = {
        'firstName': firstName.text.trim(),
        'lastName': lastName.text.trim(),
      };
      await userRepository.updateSingleField(name);

      // Update the Rx User value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      // Fetch New User Data
      await UserController.instance.fetchUserRecord();

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Move to previous screen (Get.off(() => ProfileScreen()); will result in two duplicate screens)
      Get.back();

      // then Show Success Message
      Loaders.successSnackBar(
        title: 'Changes have been saved',
        message: 'Your name has been updated.',
      );
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: CTexts.ohSnap, message: e.toString());
    }
  }
}

import 'package:clothiva_project/data/repositories/authentication/authentication_repository.dart';
import 'package:clothiva_project/data/repositories/user/user_repository.dart';
import 'package:clothiva_project/features/authentication/models/user_model.dart';
import 'package:clothiva_project/features/authentication/screens/signup/verify_email.dart';
import 'package:clothiva_project/utils/constants/image_strings.dart';
import 'package:clothiva_project/utils/constants/text_strings.dart';
import 'package:clothiva_project/utils/helpers/exports.dart';
import 'package:clothiva_project/utils/popups/full_screen_loader.dart';
import 'package:clothiva_project/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  ///Variables
  final hidePassword = true
      .obs; //Observable for hiding/showing password (State Management for stateless widgets, this UI can change)
  final privacybox = false.obs;
  final email = TextEditingController(); // Controller for email input
  final firstname = TextEditingController(); // Controller for first name input
  final lastname = TextEditingController(); // Controller for last name input
  final username = TextEditingController(); // Controller for username input
  final password = TextEditingController(); // Controller for password input
  final phonenumber =
      TextEditingController(); // Controller for phone number input
  GlobalKey<FormState> signupFormKey =
      GlobalKey<FormState>(); // Form Key for form validation

  ///MARK: - SIGNUP
  void signup() async {
    try {
      //Start Loading
      FullScreenLoader.openLoadingDialog(
        'We are processing your information',
        CImages.docerAnimation,
      );

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        Loaders.customToast(message: 'No Internet Connection');
        return;
      }

      //Form Validation
      if (!signupFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      //Privacy Policy Check
      if (!privacybox.value) {
        FullScreenLoader.stopLoading();
        Loaders.warningSnackBar(
          title: CTexts.privacyuncheckedTitle,
          message: CTexts.privacyuncheckedSubTitle,
        );
        return;
      }

      //Register user in the Firebase Authentication & Save user data in the Firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
            email.text.trim(),
            password.text.trim(),
          ); //.trim() to remove spaces

      //Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstname.text.trim(),
        lastName: lastname.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phonenumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(
        UserRepository(),
      ); //.instance can't be used here as UserRepository should be called once with Get.put to be created
      await userRepository.saveUserRecord(newUser);

      FullScreenLoader.stopLoading();
      //Show Success Message
      Loaders.successSnackBar(
        title: CTexts.congratulations,
        message: CTexts.accountCreatedVerifyEmail,
      );

      //Move to verify Email Screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      // Show some Generic Error to the user
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: CTexts.ohSnap, message: e.toString());
    }
  }
}

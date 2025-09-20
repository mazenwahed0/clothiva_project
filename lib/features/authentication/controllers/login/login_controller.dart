import 'package:clothiva_project/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// TextField Controllers to get data from TextFields in Login Form
  //These Variables are being observed by some entity provided by the Getx which is *Obx*
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  /// Loader
  final isLoading = false.obs;
  final isGoogleLoading = false.obs;
  final isFacebookLoading = false.obs;

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  /// [EmailAndPasswordLogin]
  Future<void> emailAndPasswordLogin() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
        'Logging you in...',
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
      if (!loginFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      //Save Data if Remember Me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      } else {
        await localStorage.remove('REMEMBER_ME_EMAIL');
        await localStorage.remove('REMEMBER_ME_PASSWORD');
      }

      // Login user using Email & Password Authentication
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // final userController = Get.put(UserController());
      // await userController.updateUserRecordWithToken(token);
      // // Assign user data to RxUser of UserController to use in app
      // await userController.fetchUserRecord();

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Redirect
      await AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: CTexts.ohSnap, message: e.toString());
    }
  }

  // /// [GoogleSignInAuthentication]
  // Future<void> googleSignIn() async {
  //   try {
  //     // Start Loading
  //     FullScreenLoader.openLoadingDialog(
  //         'Logging you in...', CImages.docerAnimation);

  //     // Check Internet Connectivity
  //     final isConnected = await NetworkManager.instance.isConnected();
  //     if (!isConnected) {
  //       FullScreenLoader.stopLoading();
  //       return;
  //     }

  //     // Sign In with Google
  //     final userCredentials =
  //         await AuthenticationRepository.instance.signInWithGoogle();

  //     final userController = Get.put(UserController());
  //     // Save Authenticated user data in the Firebase Firestore
  //     await userController.saveUserRecord(userCredentials: userCredentials);

  //     Get.put(CreateNotificationController());
  //     await CreateNotificationController.instance.createNotification();

  //     // Remove Loader
  //     FullScreenLoader.stopLoading();

  //     // Redirect
  //     await AuthenticationRepository.instance
  //         .screenRedirect(userCredentials?.user);
  //   } catch (e) {
  //     FullScreenLoader.stopLoading();
  //     Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
  //   }
  // }
}

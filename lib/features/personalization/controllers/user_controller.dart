import 'dart:io';

import 'package:clothiva_project/features/authentication/screens/login/login.dart';
import 'package:clothiva_project/utils/constants/keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common/widgets/loaders/circular_loader.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/services/storage/cloudinary_service.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../screens/profile/widgets/re_authenticate_user_login_form.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  /// Repositories
  Rx<UserModel> user = UserModel.empty().obs;
  final profileLoading = false.obs;
  final hidePassword = true.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  final cloudinaryService = Get.put(CloudinaryService());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  // Profile Screen Controllers
  final email = TextEditingController();
  final phoneNo = TextEditingController();
  final fullName = TextEditingController();
  final imageUploading = false.obs;
  final profileImageUrl = ''.obs;
  GlobalKey<FormState> updateUserProfileFormKey = GlobalKey<FormState>();

  /// init user data when Home Screen appears
  @override
  void onInit() {
    fetchUserRecord();
    super.onInit();
  }

  /// Save user Record from any Registration provider
  Future<void> saveUserRecord({
    UserModel? user,
    UserCredential? userCredentials,
  }) async {
    try {
      // First Update Rx User and then check if user data is already stored. If not store new data
      await fetchUserRecord();

      // If no record alread stored. New User.
      if (this.user.value.id.isEmpty) {
        if (userCredentials != null) {
          //Convert Name to First and Last Name
          final nameParts = UserModel.nameParts(
            userCredentials.user!.displayName ?? '',
          );
          final username = UserModel.generateUsername(
            userCredentials.user!.displayName ?? '',
          );

          //Map Data
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1
                ? nameParts.sublist(1).join(' ')
                : '',
            username: username,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

          //Save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      Loaders.warningSnackBar(
        title: 'Data not saved',
        message:
            'Something went wrong while saving your information. You can re-save your data in your Profile.',
      );
    }
  }

  /// Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
      profileLoading.value = false;
    } catch (e) {
      user(UserModel.empty());
      Loaders.warningSnackBar(
        title: 'Warning',
        message: 'Unable to fetch your information. Try again.',
      );
    } finally {
      profileLoading.value = false;
    }
  }

  /// Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(CSizes.md),
      title: 'Delete Account',
      titleStyle: const TextStyle(
        color: Colors.black, // Force black title
      ),
      middleText:
          'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
      middleTextStyle: const TextStyle(
        color: Colors.black, // Force black content
      ),
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: CSizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        child: const Text(
          'Cancel',
          style: TextStyle(
            color: Colors.black, // Force black content
          ),
        ),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ),
    );
  }

  /// Delete User Account
  void deleteUserAccount() async {
    try {
      FullScreenLoader.openLoadingDialog('Processing', CImages.docerAnimation);

      /// First re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider = auth.firebaseUser!.providerData
          .map((e) => e.providerId)
          .first;
      if (provider.isNotEmpty) {
        // Re Verify Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          FullScreenLoader.stopLoading();
          Get.offAll(() => LoginScreen());
        } else if (provider == 'password') {
          FullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// -- RE-AUTHENTICATE before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      FullScreenLoader.openLoadingDialog('Processing', CImages.docerAnimation);

      //Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
            verifyEmail.text.trim(),
            verifyPassword.text.trim(),
          );
      await AuthenticationRepository.instance.deleteAccount();
      FullScreenLoader.stopLoading();
      Get.offAll(() => LoginScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// Logout Loader Function
  logout() {
    try {
      Get.defaultDialog(
        contentPadding: const EdgeInsets.all(CSizes.md),
        title: 'Logout',
        middleText: 'Are you sure you want to Logout?',
        confirm: ElevatedButton(
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: CSizes.lg,
              vertical: CSizes.xs / 2,
            ),
            child: Text('Confirm'),
          ),
          onPressed: () async {
            onClose();

            /// On Confirmation show any loader until user Logged Out.
            Get.defaultDialog(
              title: '',
              barrierDismissible: false,
              backgroundColor: Colors.transparent,
              content: const CircularLoader(),
            );
            await AuthenticationRepository.instance.logout();
          },
        ),
        cancel: OutlinedButton(
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: CSizes.xs,
              vertical: CSizes.xs,
            ),
            child: Text('Cancel'),
          ),
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        ),
      );
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  void assignDataToProfile() {
    fullName.text = user.value.fullName;
    email.text = user.value.email;
    phoneNo.text = user.value.phoneNumber;
  }

  /// Upload Profile Picture
  uploadUserProfilePicture() async {
    try {
      // Pick Image from Gallery
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (image != null) {
        imageUploading.value = true;

        // Convert XFile to File
        File file = File(image.path);

        // Delete User Current Profile Picture
        if (user.value.publicId.isNotEmpty) {
          await cloudinaryService.deleteImage(user.value.publicId);
        }

        // Upload to Cloudinary
        final response = await cloudinaryService.uploadImage(
          file,
          CKeys.profileFolder,
          publicId: user.value.id,
        );
        if (response.statusCode == 200) {
          // Get Data
          final data = response.data;
          // Cloudinary returns JSON, get the secure_url
          final imageUrl = data['secure_url'];
          final publicId = data['public_id'];

          // Update Firestore User Image Record (User Repo)
          await userRepository.updateSingleField({
            'profilePicture': imageUrl,
            'publicId': publicId,
          });

          // Update Profile and Public ID from RX User (local user model)
          user.value.profilePicture = imageUrl;
          user.value.publicId = publicId;

          user.refresh();

          imageUploading.value = false;
          Loaders.successSnackBar(
            title: 'Success!',
            message: 'Your Profile Image has been updated!',
          );
        } else {
          throw 'Failed to upload profile picture. Please try again';
        }
      }
    } catch (e) {
      imageUploading.value = false;
      Loaders.errorSnackBar(title: 'Failed', message: e.toString());
    }
  }
}

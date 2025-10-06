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

  // /// Fetch user record
  // Future<void> fetchUserRecord({bool fetchLatestRecord = false}) async {
  //   try {
  //     if (fetchLatestRecord) {
  //       profileLoading.value = true;
  //       final user = await userRepository.fetchUserDetails();
  //       this.user(user);
  //     } else {
  //       // Check if user is logged in and has a valid ID
  //       if (user.value.id != AuthenticationRepository.instance.getUserID) {
  //         user.value = UserModel.empty();
  //       }

  //       // Fetch user data from the repository
  //       if (user.value.id.isEmpty) {
  //         profileLoading.value = true;
  //         final user = await userRepository.fetchUserDetails();
  //         this.user(user);
  //       }
  //     }
  //   } catch (e) {
  //     Loaders.warningSnackBar(
  //         title: 'Warning',
  //         message: 'Unable to fetch your information. Try again.');
  //   } finally {
  //     profileLoading.value = false;
  //   }
  // }

  // /// Save user Record from any Registration provider
  // Future<void> saveUserRecord({UserModel? user, UserCredential? userCredentials}) async {
  //   try {
  //     // First UPDATE Rx User and then check if user data is already stored. If not store new data
  //     await fetchUserRecord();

  //     // If no record already stored.
  //     if (this.user.value.id.isEmpty) {
  //       if (userCredentials != null) {
  //         // final fcmToken = await TNotificationService.getToken();
  //         // Map data
  //         final newUser = UserModel(
  //           id: userCredentials.user!.uid,
  //           fullName: userCredentials.user!.displayName ?? '',
  //           email: userCredentials.user!.email ?? '',
  //           profilePicture: userCredentials.user!.photoURL ?? '',
  //           // deviceToken: fcmToken,
  //           isEmailVerified: true,
  //           isProfileActive: true,
  //           updatedAt: DateTime.now(),
  //           createdAt: DateTime.now(),
  //           verificationStatus: VerificationStatus.approved,
  //           phoneNumber: '',
  //         );

  //         // Save user data
  //         await userRepository.saveUserRecord(newUser);

  //         // Assign new user to the RxUser so that we can use it through out the app.
  //         this.user(newUser);
  //       } else if (user != null) {
  //         // Save Model when user registers using Email and Password
  //         await userRepository.saveUserRecord(user);

  //         // Assign new user to the RxUser so that we can use it through out the app.
  //         this.user(user);
  //       }
  //     }
  //   } catch (e) {
  //     Loaders.warningSnackBar(
  //       title: 'Data not saved',
  //       message: 'Something went wrong while saving your information. You can re-save your data in your Profile.',
  //     );
  //   }
  // }

  // Future<void> updateUserProfile() async {
  //   try {
  //     // Start Loading
  //     FullScreenLoader.openLoadingDialog('We are updating your information...', TImages.docerAnimation);

  //     // Check Internet Connectivity
  //     final isConnected = await NetworkManager.instance.isConnected();
  //     if (!isConnected) {
  //       FullScreenLoader.stopLoading();
  //       return;
  //     }

  //     // Form Validation
  //     if (!updateUserProfileFormKey.currentState!.validate()) {
  //       FullScreenLoader.stopLoading();
  //       return;
  //     }

  //     // Update user's first & last name in the Firebase Firestore
  //     Map<String, dynamic> json = {'fullName': fullName.text.trim(), 'email': email.text.trim()};
  //     await userRepository.updateSingleField(json);

  //     // Update the Rx User value
  //     user.value.fullName = fullName.text.trim();
  //     user.value.email = email.text.trim();
  //     user.value.phoneNumber = phoneNo.text.trim();

  //     // Remove Loader
  //     FullScreenLoader.stopLoading();

  //     // Show Success Message
  //     Loaders.successSnackBar(title: 'Congratulations', message: 'Your Name has been updated.');

  //     // Move to previous screen.
  //     Get.offNamed(CRoutes.profileScreen);
  //   } catch (e) {
  //     FullScreenLoader.stopLoading();
  //     Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
  //   }
  // }

  // /// Upload Profile Picture
  // uploadUserProfilePicture() async {
  //   try {
  //     final image = await ImagePicker().pickImage(
  //       source: ImageSource.gallery,
  //       imageQuality: 70,
  //       maxHeight: 512,
  //       maxWidth: 512,
  //     );
  //     if (image != null) {
  //       // Upload Image
  //       imageUploading.value = true;
  //       final uploadedImage = await userRepository.uploadImage(
  //         'Users/Images/Profile/',
  //         image,
  //       );
  //       profileImageUrl.value = uploadedImage;
  //       Map<String, dynamic> newImage = {'profilePicture': uploadedImage};
  //       await userRepository.updateSingleField(newImage);
  //       user.value.profilePicture = uploadedImage;
  //       user.refresh();

  //       imageUploading.value = false;
  //       Loaders.successSnackBar(
  //         title: 'Congratulations',
  //         message: 'Your Profile Image has been updated!',
  //       );
  //     }
  //   } catch (e) {
  //     imageUploading.value = false;
  //     Loaders.errorSnackBar(
  //       title: 'OhSnap',
  //       message: 'Something went wrong: $e',
  //     );
  //   }
  // }

  // /// Update user record after login (e.g., to update token)
  // Future<void> updateUserRecordWithToken(String newToken) async {
  //   try {
  //     // Ensure we have fetched the user record before updating
  //     await fetchUserRecord();
  //     // Create a map to store the fields we want to update (e.g., token)
  //     Map<String, dynamic> updatedFields = {'deviceToken': newToken};

  //     // Call the repository to update the specific fields
  //     await userRepository.updateSingleField(updatedFields);

  //     // Update the local RxUser object with the new token
  //     user.value.deviceToken = newToken;
  //     user.refresh();
  //   } catch (e) {
  //     TLoaders.errorSnackBar(
  //       title: 'Error',
  //       message: 'Failed to update user record: $e',
  //     );
  //   }
  // }

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

  // /// Delete User Account
  // void deleteUserAccount() async {
  //   try {
  //     FullScreenLoader.openLoadingDialog('Processing', CImages.docerAnimation);

  //     /// First re-authenticate user
  //     final auth = AuthenticationRepository.instance;
  //     final provider =
  //         auth.firebaseUser!.providerData.map((e) => e.providerId).first;
  //     if (provider.isNotEmpty) {
  //       // Re Verify Auth Email
  //       if (provider == 'google.com') {
  //         await auth.signInWithGoogle();
  //         await auth.deleteAccount();
  //         FullScreenLoader.stopLoading();
  //         Get.offAllNamed(TRoutes.logIn);
  //       } else if (provider == 'facebook.com') {
  //         TFullScreenLoader.stopLoading();
  //         Get.offAllNamed(TRoutes.logIn);
  //       } else if (provider == 'password') {
  //         TFullScreenLoader.stopLoading();
  //         Get.to(() => const ReAuthLoginForm());
  //       } else if (provider == 'phone') {
  //         TFullScreenLoader.stopLoading();
  //         await AuthenticationRepository.instance
  //             .loginWithPhoneNo(user.value.phoneNumber);
  //         bool otpVerified = await Get.toNamed(
  //             TRoutes.reAuthenticateOtpVerification,
  //             parameters: {
  //               'phoneNumberWithCountryCode': user.value.phoneNumber
  //             });
  //         if (otpVerified) {
  //           TLoaders.successSnackBar(
  //               title: TTexts.phoneVerifiedTitle,
  //               message: TTexts.phoneVerifiedMessage);
  //           await auth.deleteAccount();
  //           Get.offAll(() => const WelcomeScreen());
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     TFullScreenLoader.stopLoading();
  //     TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
  //   }
  // }

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
        titleStyle: const TextStyle(
          color: Colors.black, // Force black title
        ),
        middleText: 'Are you sure you want to Logout?',
        middleTextStyle: const TextStyle(
          color: Colors.black, // Force black title
        ),
        confirm: ElevatedButton(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: CSizes.lg),
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
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.black, // Force black title
            ),
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

  // /// Upload Profile Picture
  // uploadUserProfilePicture() async {
  //   try {
  //     final image = await ImagePicker().pickImage(
  //       source: ImageSource.gallery,
  //       imageQuality: 70,
  //       maxHeight: 512,
  //       maxWidth: 512,
  //     );
  //     if (image != null) {
  //       imageUploading.value = true;
  //       // Upload Image
  //       // final uploadedImage = await userRepository.uploadImage(
  //       //   'Users/Images/Profile/',
  //       //   image,
  //       // );

  //       // Upload to Cloudinary
  //       final uploadedImage = await cloudinaryService.uploadImage(
  //         image.path,
  //         user.value.id,
  //         folder: 'Users/Profile',
  //       );

  //       // Update Firestore User Image Record (User Repo)
  //       profileImageUrl.value = uploadedImage;
  //       Map<String, dynamic> newImage = {'profilePicture': uploadedImage};
  //       await userRepository.updateSingleField(newImage);

  //       // Update local user model
  //       user.value.profilePicture = uploadedImage;
  //       user.refresh();

  //       imageUploading.value = false;
  //       Loaders.successSnackBar(
  //         title: 'Changes have been saved',
  //         message: 'Your Profile Image has been updated!',
  //       );
  //     }
  //   } catch (e) {
  //     imageUploading.value = false;
  //     Loaders.errorSnackBar(
  //       title: 'OhSnap',
  //       message: 'Something went wrong: $e',
  //     );
  //   }
  // }
}

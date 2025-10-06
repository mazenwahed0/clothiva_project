import 'package:clothiva_project/data/services/storage/cloudinary_service.dart';
import 'package:clothiva_project/features/authentication/screens/login/login.dart';
import 'package:clothiva_project/features/personalization/controllers/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../features/authentication/screens/signup/verify_email.dart';
import '../../../navigation_menu.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../user/user_repository.dart';

class AuthenticationRepository extends GetxController {
  // Only one instance out of this class
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage =
      GetStorage(); // Use this to store data locally (e.g. OnBoarding)
  late final Rx<User?> _firebaseUser;
  var phoneNo = ''.obs;
  var phoneNoVerificationId = ''.obs;
  var isPhoneAutoVerified = false;
  final _auth = FirebaseAuth.instance;
  // int? _resendToken;

  /// Getters
  // Get Authenticated User Data
  User? get authUser => _auth.currentUser;

  User? get firebaseUser => _firebaseUser.value;

  String get getUserID => firebaseUser?.uid ?? "";

  String get getUserEmail => firebaseUser?.email ?? "";

  String get getDisplayName => firebaseUser?.displayName ?? "";

  String get getPhoneNo => firebaseUser?.phoneNumber ?? "";

  /// Called from main.dart on app launch
  @override
  void onReady() {
    _firebaseUser = Rx<User?>(authUser);
    _firebaseUser.bindStream(_auth.userChanges());
    FlutterNativeSplash.remove();
    screenRedirect();
    // ever(_firebaseUser, _setInitialScreen);
  }

  /// Function to Show Relevant Screen
  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => NavigationMenu()); //Supposed to be NavigationMenu()
      } else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  /* ---------------------------- Email & Password sign-in ---------------------------------*/

  /// [EmailAuthentication] - LOGIN
  Future<UserCredential> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw CFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailAuthentication] - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ); //If success we'll move data to firestore and save it
    } on FirebaseAuthException catch (e) {
      throw CFirebaseAuthException(
        e.code,
      ).message; //The reason to catch these exceptions seperately is to make sure that the user can see a relevant message but NOT a Technical Message
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [ReAuthenticate] - ReAuthenticate User
  Future<void> reAuthenticateWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      // Create a credential
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      // ReAuthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw CFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailVerification] - MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw CFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailAuthentication] - FORGET PASSWORD
  Future<void> sendPasswordResetEmail(email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw CFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /* ---------------------------- Federated identity & social sign-in ---------------------------------*/

  /// [GoogleAuthentication] - GOOGLE
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null; // user canceled

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw CFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) debugPrint('Something went wrong: $e');
      return null;
    }
  }

  /* ---------------------------- Phone Number sign-in ---------------------------------*/

  // /// [PhoneAuthentication] - LOGIN - Register
  // Future<void> loginWithPhoneNo(String phoneNumber) async {
  //   try {
  //     await _auth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       forceResendingToken: _resendToken,
  //       timeout: const Duration(minutes: 2),
  //       verificationFailed: (e) async {
  //         debugPrint('loginWithPhoneNo: verificationFailed => $e');
  //         await FirebaseCrashlytics.instance.recordError(e, e.stackTrace);

  //         if (e.code == 'too-many-requests') {
  //           // Get.offAllNamed(TRoutes.welcome);
  //           Get.offAll(() => const WelcomeScreen());
  //           TLoaders.warningSnackBar(
  //               title: 'Too many attempts',
  //               message:
  //                   'Oops! Too many tries. Take a short break and try again soon!');
  //           return;
  //         } else if (e.code == 'unknown') {
  //           Get.back(result: false);
  //           TLoaders.warningSnackBar(
  //               title: 'SMS not Sent',
  //               message:
  //                   'An internal error has occurred, We are working on it!');
  //           return;
  //         }
  //         TLoaders.warningSnackBar(title: 'Oh Snap', message: e.message ?? '');
  //       },
  //       codeSent: (verificationId, resendToken) {
  //         debugPrint('--------------- codeSent');
  //         phoneNoVerificationId.value = verificationId;
  //         _resendToken = resendToken;
  //         debugPrint('--------------- codeSent: $verificationId');
  //       },
  //       verificationCompleted: (credential) async {
  //         debugPrint('--------------- verificationCompleted');
  //         var signedInUser = await _auth.signInWithCredential(credential);
  //         isPhoneAutoVerified = signedInUser.user != null;

  //         // await screenRedirect(
  //         //   _auth.currentUser,
  //         //   pinScreen: true,
  //         //   stopLoadingWhenReady: true,
  //         //   phoneNumber: phoneNumber,
  //         // );
  //         await screenRedirect(_auth.currentUser);
  //       },
  //       codeAutoRetrievalTimeout: (verificationId) {
  //         // phoneNoVerificationId.value = verificationId;
  //         debugPrint(
  //             '--------------- codeAutoRetrievalTimeout: $verificationId');
  //       },
  //     );
  //     phoneNo.value = phoneNumber;
  //   } on FirebaseAuthException catch (e) {
  //     throw TFirebaseAuthException(e.code).message;
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.code).message;
  //   } on FormatException catch (_) {
  //     throw const TFormatException();
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again';
  //   }
  // }

  // /// [PhoneAuthentication] - VERIFY PHONE NO BY OTP
  // Future<bool> verifyOTP(String otp) async {
  //   try {
  //     final phoneCredentials = PhoneAuthProvider.credential(
  //         verificationId: phoneNoVerificationId.value, smsCode: otp);
  //     var credentials = await _auth.signInWithCredential(phoneCredentials);
  //     return credentials.user != null ? true : false;
  //   } on FirebaseAuthException catch (e) {
  //     await FirebaseCrashlytics.instance.recordError(e, e.stackTrace);
  //     throw TFirebaseAuthException(e.code).message;
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.code).message;
  //   } on FormatException catch (_) {
  //     throw const TFormatException();
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again';
  //   } finally {
  //     phoneNo.value = '';
  //     isPhoneAutoVerified = false;
  //   }
  // }

  /* ---------------------------- ./end Federated identity & social sign-in ---------------------------------*/

  /// [LogoutUser] - Valid for any authentication.
  Future<void> logout() async {
    try {
      await _auth.signOut();
      await GoogleSignIn().signOut();
      // await FacebookAuth.instance.logOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw CFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// DELETE USER - Remove user Auth and Firestore Account.
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);

      // Remove Profile Picture from Cloudinary
      String publicId = UserController.instance.user.value.publicId;
      if (publicId.isNotEmpty) {
        CloudinaryService.instance.deleteImage(publicId);
      }

      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw CFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}

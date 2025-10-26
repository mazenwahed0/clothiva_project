import 'package:clothiva_project/features/personalization/controllers/address_controller.dart';
import 'package:clothiva_project/features/shop/controllers/product/checkout_controller.dart';
import 'package:clothiva_project/features/shop/controllers/product/image_controller.dart';
import 'package:get/get.dart';

import '../data/repositories/authentication/authentication_repository.dart';

import '../features/authentication/controllers/signup/signup_controller.dart';
import '../utils/helpers/network_manager.dart';

import 'package:clothiva_project/features/shop/controllers/product/cart_controller.dart';
import 'package:clothiva_project/features/shop/controllers/product/variation_controller.dart';

// Get.put(): Puts an instance of a class into the GetX dependency injection system once
// By default, it creates the instance immediately and keeps it in memory as a singleton.
// Every time you call Get.find<Controller>(), you get the same instance.

// Get.create(): Provides a new instance every time you ask for it.
// Every call to Get.find<Controller>() creates a fresh instance.
// Good for short-lived objects or widgets that are disposed often.

/// To avoid calling Get.put several times.
class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    /// -- Core
    Get.put(NetworkManager());

    /// -- Repository
    Get.lazyPut(() => AuthenticationRepository(), fenix: true);
    // Get.put(CartController());
    // Get.put(ThemeController());
    // Get.put(ProductController());
    // Get.lazyPut(() => UserController());
    // Get.lazyPut(() => CheckoutController());
    // Get.lazyPut(() => AddressController());

    // Get.lazyPut(() => OnBoardingController(), fenix: true);

    // Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => SignupController(), fenix: true);
    // Get.lazyPut(() => OTPController(), fenix: true);
    // Get.put(TNotificationService());
    // Get.lazyPut(() => NotificationController(), fenix: true);
    Get.put(VariationController(), permanent: true);
    Get.put(CartController(), permanent: true);
    Get.put(AddressController());
    Get.put(CheckoutController());
  }
}

// Willy

// import 'package:get/get.dart';
// import 'package:clothiva_project/utils/helpers/network_manager.dart';
// import 'package:clothiva_project/data/repositories/authentication/authentication_repository.dart';
// import 'package:clothiva_project/features/shop/controllers/product/variation_controller.dart';
// import 'package:clothiva_project/features/shop/controllers/product/cart_controller.dart';

// class GeneralBindings extends Bindings {
//   @override
//   void dependencies() {
//     Get.put(NetworkManager());
//     Get.lazyPut(() => AuthenticationRepository(), fenix: true);
//     Get.put(VariationController());
//     Get.put(CartController());
//   }
// }

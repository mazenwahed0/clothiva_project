import 'package:clothiva_project/features/invitation/data/repositories/invitation_repo.dart';
import 'package:clothiva_project/features/invitation/presentation/Invitation/invitation_controller.dart';
import 'package:clothiva_project/features/shop/controllers/products/favourites_controller.dart';
import 'package:get/get.dart';

import '../data/repositories/authentication/authentication_repository.dart';

import '../features/authentication/controllers/signup/signup_controller.dart';
import '../features/personalization/controllers/address_controller.dart';
import '../features/personalization/controllers/user_controller.dart';
import '../features/shop/controllers/brand_controller.dart';
import '../features/cart/controllers/cart_controller.dart';
import '../features/checkout/controllers/checkout_controller.dart';
import '../features/shop/controllers/products/product_controller.dart';
import '../features/shop/controllers/products/variation_controller.dart';
import '../utils/helpers/network_manager.dart';

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

    Get.lazyPut(() => InvitationRepository(), fenix: true);
    Get.lazyPut<InvitationController>(
      () => InvitationController(Get.find()),
      fenix: true,
    );

    // Get.put(CartController());
    // // Get.put(ThemeController());
    Get.put(VariationController());
    // Get.put(ProductController());

    Get.lazyPut(() => FavouritesController(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => BrandController(), fenix: true);
    Get.lazyPut(() => CheckoutController(), fenix: true);
    Get.lazyPut(() => AddressController(), fenix: true);

    // Get.lazyPut(() => OnBoardingController(), fenix: true);

    // Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => SignupController(), fenix: true);
    // Get.lazyPut(() => OTPController(), fenix: true);
    // Get.put(TNotificationService());
    // Get.lazyPut(() => NotificationController(), fenix: true);
    // Get.put(VariationController(), permanent: true);
    Get.put(CartController(), permanent: true);
    Get.put(AddressController());
    Get.put(CheckoutController());
  }
}

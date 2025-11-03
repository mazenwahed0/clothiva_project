import 'package:get/get.dart';

import '../data/repositories/authentication/authentication_repository.dart';
import '../data/repositories/invitation/invitation_repository.dart';
import '../data/repositories/user/user_repository.dart';
import '../data/repositories/wishlist/wishlist_repository.dart';
import '../features/authentication/controllers/signup/signup_controller.dart';
import '../features/cart/controllers/cart_controller.dart';
import '../features/checkout/controllers/checkout_controller.dart';
import '../features/invitation/controllers/invitation_controller.dart';
import '../features/personalization/controllers/address_controller.dart';
import '../features/personalization/controllers/user_controller.dart';
import '../features/shop/controllers/brand_controller.dart';
import '../features/shop/controllers/products/favourites_controller.dart';
import '../features/shop/controllers/products/variation_controller.dart';
import '../utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    /// -- Core
    Get.put(NetworkManager());

    /// -- Repositories
    Get.lazyPut(() => AuthenticationRepository(), fenix: true);
    Get.lazyPut(() => InvitationRepository(), fenix: true);
    Get.lazyPut(() => WishlistRepository(), fenix: true);
    Get.lazyPut(() => UserRepository(), fenix: true);

    /// -- Controllers
    Get.put(FavouritesController(), permanent: true);
    Get.put(VariationController());
    Get.put(CartController(), permanent: true);

    Get.lazyPut(() => InvitationController(), fenix: true);

    Get.put(AddressController());
    Get.put(CheckoutController());

    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => BrandController(), fenix: true);
    Get.lazyPut(() => SignupController(), fenix: true);
  }
}

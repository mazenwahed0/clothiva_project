import 'package:clothiva_project/data/repositories/address/address_repository.dart';
import 'package:clothiva_project/features/order/controllers/order_controller.dart';
import 'package:get/get.dart';

import '../data/repositories/authentication/authentication_repository.dart';
import '../data/repositories/banners/banner_repository.dart';
import '../data/repositories/brands/brand_repository.dart';
import '../data/repositories/categories/category_repository.dart';
import '../data/repositories/invitation/invitation_repository.dart';
import '../data/repositories/order/order_repository.dart';
import '../data/repositories/product/product_repository.dart';
import '../data/repositories/user/user_repository.dart';
import '../data/repositories/wishlist/wishlist_repository.dart';
import '../features/authentication/controllers/signup/signup_controller.dart';
import '../features/cart/controllers/cart_controller.dart';
import '../features/checkout/controllers/checkout_controller.dart';
import '../features/invitation/controllers/invitation_controller.dart';
import '../features/personalization/controllers/address_controller.dart';
import '../features/personalization/controllers/theme_controller.dart';
import '../features/personalization/controllers/user_controller.dart';
import '../features/shop/controllers/brand_controller.dart';
import '../features/shop/controllers/products/favourites_controller.dart';
import '../features/shop/controllers/products/product_controller.dart';
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
    Get.lazyPut(() => AddressRepository(), fenix: true);
    Get.lazyPut(() => OrderRepository(), fenix: true);
    Get.lazyPut(() => ProductRepository(), fenix: true);
    Get.lazyPut(() => BrandRepository(), fenix: true);
    Get.lazyPut(() => CategoryRepository(), fenix: true);
    Get.lazyPut(() => BannerRepository(), fenix: true);

    /// -- Controllers
    Get.put(ThemeController());
    Get.put(FavouritesController(), permanent: true);
    Get.put(VariationController());
    Get.put(CartController(), permanent: true);
    Get.lazyPut(() => ProductController(), fenix: true);
    Get.lazyPut(() => AddressController(), fenix: true);
    Get.lazyPut(() => OrderController(), fenix: true);
    Get.lazyPut(() => CheckoutController(), fenix: true);

    Get.lazyPut(() => InvitationController(), fenix: true);

    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => BrandController(), fenix: true);
    Get.lazyPut(() => SignupController(), fenix: true);
  }
}

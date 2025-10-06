import 'package:clothiva_project/features/personalization/screens/settings/settings.dart';
import 'package:get/get.dart';

import '../features/personalization/screens/profile/profile.dart';
import '../features/shop/screens/home/home.dart';
import '../features/shop/screens/wishlist/wishlist.dart';
import 'routes.dart';

class AppRoutes {
  static final screens = [
    GetPage(name: CRoutes.home, page: () => HomeScreen()),
    // GetPage(name: CRoutes.store, page: () => const StoreScreen(),),
    GetPage(name: CRoutes.wishlist, page: () => const WishlistScreen()),
    GetPage(name: CRoutes.settings, page: () => const SettingsScreen()),
    // GetPage(name: CRoutes.order, page: () => const OrderScreen(),),
    // GetPage(name: CRoutes.checkout, page: () => const CheckoutScreen(),),
    // GetPage(name: CRoutes.cart, page: () => const CartScreen(),),
    GetPage(name: CRoutes.userProfile, page: () => const ProfileScreen()),
    // GetPage(name: CRoutes.userAddress, page: () => const AddressScreen(),),
    // GetPage(name: CRoutes.signup, page: () => const SignupScreen(),),
    // GetPage(name: CRoutes.verifyEmail, page: () => const VerifyEmailScreen(),),
    // GetPage(name: CRoutes.signIn, page: () => const LoginScreen(),),
    // GetPage(name: CRoutes.forgetPassword, page: () => const ForgetPasswordScreen(),),
    // GetPage(name: CRoutes.onBoarding, page: () => const OnboardingScreen(),),
  ];
}

import 'package:clothiva_project/common/widgets/success_screen/success_screen.dart';
import 'package:clothiva_project/data/repositories/authentication/authentication_repository.dart';
import 'package:clothiva_project/data/repositories/order/order_repository.dart';
import 'package:clothiva_project/features/personalization/controllers/address_controller.dart';
import 'package:clothiva_project/features/shop/controllers/product/cart_controller.dart';
import 'package:clothiva_project/features/shop/controllers/product/checkout_controller.dart';
import 'package:clothiva_project/navigation_menu.dart';
import 'package:clothiva_project/utils/constants/enums.dart';
import 'package:clothiva_project/utils/constants/image_strings.dart';
import 'package:clothiva_project/utils/popups/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:clothiva_project/features/cart/models/order_model.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  // Variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  // Fetch User's order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      Loaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  // Add Method for order processing
  void processOrder(double totalAmount) async {
    try {
      FullScreenLoader.openLoadingDialog(
        'Processing Your Order',
        CImages.signInAnimation,
      );

      // Get User Auth ID
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) return;

      // Add Details
      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        status: Orderstatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.toList(),
      );

      // Save The Order To FireStore
      await orderRepository.saveOrder(order, userId);

      // Update The Cart Status
      cartController.clearCart();

      // Show Success Screen
      Get.off(
        () => SuccessSignupScreen(
          image: CImages.successfullyRegisterAnimation,
          title: 'Payment Success!',
          subTitle: 'Your Item Will Be Shipped Soon!',
          onPressed: () => Get.offAll(() => const NavigationMenu()),
        ),
      );
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}

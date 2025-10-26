import 'package:clothiva_project/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:clothiva_project/common/widgets/products/cart/coupon_widget.dart';
import 'package:clothiva_project/features/shop/controllers/product/order_controller.dart';
import 'package:clothiva_project/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:clothiva_project/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:clothiva_project/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:clothiva_project/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:clothiva_project/utils/helpers/pricing_functions.dart';
import 'package:clothiva_project/utils/popups/exports.dart';
import 'package:flutter/material.dart';
import 'package:clothiva_project/common/widgets/appbar/appbar.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:clothiva_project/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:clothiva_project/features/shop/controllers/product/cart_controller.dart';

class CheckoutScreen extends StatelessWidget {
  CartController get cartController => CartController.instance; ////////////
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount = CPricingCalculator.calculateTotalPrice(subTotal, 'US');
    bool dark = context.isDarkMode || context.isDarkModeMedia;
    return Scaffold(
      appBar: CAppBar(
        showActions: false,
        showSkipButton: false,
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              /// Item In Cart
              CCartItems(showAddRemoveButtons: false),
              SizedBox(height: CSizes.spaceBtSections),

              /// Coupon TextField
              CCouponCode(),
              SizedBox(height: CSizes.spaceBtSections),

              /// Billing Section
              RoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(CSizes.md),
                backgroundColor: dark ? CColors.black : CColors.white,
                child: Column(
                  children: [
                    /// Pricing
                    CBillingAmountSection(),
                    const SizedBox(height: CSizes.spaceBtItems),

                    /// Divider
                    const Divider(),
                    const SizedBox(height: CSizes.spaceBtItems),

                    /// Payment Method
                    CBillingPaymentSection(),
                    const SizedBox(height: CSizes.spaceBtItems),

                    /// Address
                    CBillingAddressSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      /// Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(CSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: subTotal > 0
              ? () => orderController.processOrder(totalAmount)
              : () => Loaders.warningSnackBar(
                  title: 'Empty Cart',
                  message: 'Add items in the cart in order to process.',
                ),
          child: Text(
            'Checkout \$${CPricingCalculator.calculateTotalPrice(subTotal, 'US').toStringAsFixed(2)}',
          ),
        ),
      ),
    );
  }
}

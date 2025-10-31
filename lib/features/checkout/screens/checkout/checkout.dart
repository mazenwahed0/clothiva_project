import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../common/widgets/products/cart/coupon_widget.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/pricing_functions.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../cart/controllers/cart_controller.dart';
import '../../controllers/order_controller.dart';
import '../../../cart/screens/cart/widgets/cart_items.dart';
import 'widgets/billing_address_section.dart';
import 'widgets/billing_amount_section.dart';
import 'widgets/billing_payment_section.dart';

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

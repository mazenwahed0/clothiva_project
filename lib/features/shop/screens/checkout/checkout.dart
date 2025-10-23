import 'package:clothiva_project/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:clothiva_project/common/widgets/products/cart/coupon_widget.dart';
import 'package:clothiva_project/common/widgets/success_signup_screen/success_signup_screen.dart';
import 'package:clothiva_project/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:clothiva_project/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:clothiva_project/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:clothiva_project/navigation_menu.dart';
import 'package:clothiva_project/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:clothiva_project/common/widgets/appbar/appbar.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:clothiva_project/utils/constants/colors.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          onPressed: () => Get.to(
            () => SuccessSignupScreen(
              image: CImages.successfullyRegisterAnimation,
              // successfullyRegisterAnimation
              title: 'Payment Success!',
              subTitle: 'Your item will be shipped soon!',
              onPressed: () => Get.offAll(() => const NavigationMenu()),
            ),
          ),
          child: Text('Checkout \$256.0'),
        ),
      ),
    );
  }
}

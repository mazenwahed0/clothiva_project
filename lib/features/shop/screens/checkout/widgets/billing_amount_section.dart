import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:clothiva_project/utils/helpers/pricing_functions.dart';
import 'package:flutter/material.dart';
import 'package:clothiva_project/features/shop/controllers/product/cart_controller.dart';

class CBillingAmountSection extends StatelessWidget {
  CartController get cartController => CartController.instance; ///////////
  const CBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final subtotal = cartController.totalCartPrice.value;
    return Column(
      children: [
        /// Subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$${subtotal.toStringAsFixed(2)}', style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
        const SizedBox(height: CSizes.spaceBtItems / 2,),

        /// Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$${double.parse(CPricingCalculator.calculateShippingCost(subtotal, 'US')).toStringAsFixed(2)}',
             style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),
        const SizedBox(height: CSizes.spaceBtItems / 2,),

        /// Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$${double.parse(CPricingCalculator.calculateTax(subtotal, 'US')).toStringAsFixed(2)}', style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),
        const SizedBox(height: CSizes.spaceBtItems / 2,),

        /// Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$${CPricingCalculator.calculateTotalPrice(subtotal, 'US').toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleMedium,),
          ],
        ),
      ],
    );
  }
}
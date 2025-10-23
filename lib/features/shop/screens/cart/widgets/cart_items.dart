import 'package:flutter/material.dart';
import 'package:clothiva_project/common/widgets/products/cart/cart_item.dart';
import 'package:clothiva_project/common/widgets/texts/product_price_text.dart';
import 'package:clothiva_project/common/widgets/products/cart/add_remove_button.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';


class CCartItems extends StatelessWidget {
  const CCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (_, __) =>
                const SizedBox(height: CSizes.spaceBtSections),
            itemCount: 2,
            itemBuilder: (_, index) => Column(
              children: [
                /// Cart Item
                CCartItem(),
                if(showAddRemoveButtons) const SizedBox(height: CSizes.spaceBtSections),
                
                /// Add Remove Buttons Row With Total Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if(showAddRemoveButtons)
                    const Row(
                      children: [
                        /// Extra Space
                        SizedBox(width: 70),

                        /// Add Reomve Buttons
                        CProductQuantityWithAddRemoveButton(),
                      ],
                    ),

                    /// Product Total Price
                    ProductPriceText(price: '256'),
                  ],
                ),
              ],
            ),
          );
  }
}
import 'package:clothiva_project/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:clothiva_project/common/widgets/products/cart/cart_item.dart';
import 'package:clothiva_project/common/widgets/texts/section_heading.dart';
import 'package:clothiva_project/utils/constants/colors.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../models/order_model.dart';
import 'widgets/order_info_row.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final dark = context.isDarkMode;
    return Scaffold(
      appBar: CAppBar(
        showBackArrow: true,
        title: Text(
          'Order Details',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showActions: false,
        showSkipButton: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// -- General Order Info
              const SectionHeading(
                title: 'Order Information',
                showActionButton: false,
              ),
              const SizedBox(height: CSizes.spaceBtItems),
              RoundedContainer(
                padding: const EdgeInsets.all(CSizes.md),
                showBorder: true,
                backgroundColor: dark ? CColors.dark : CColors.lightContainer,
                child: Column(
                  children: [
                    // Use the new widget
                    OrderInfoRow(
                      icon: Iconsax.tag,
                      title: 'Order ID',
                      value: order.id,
                    ),
                    const SizedBox(height: CSizes.spaceBtItems),
                    OrderInfoRow(
                      icon: Iconsax.calendar_1,
                      title: 'Order Date',
                      value: order.formattedOrderDate,
                    ),
                    const SizedBox(height: CSizes.spaceBtItems),
                    OrderInfoRow(
                      icon: Iconsax.ship,
                      title: 'Status',
                      value: order.orderStatusText,
                      valueColor: CColors.primary,
                    ),
                    const SizedBox(height: CSizes.spaceBtItems),
                    OrderInfoRow(
                      icon: Iconsax.calendar,
                      title: 'Delivery Date',
                      value: order.deliveryDate != null
                          ? order.formattedDeliveryDate
                          : 'N/A',
                    ),
                    const SizedBox(height: CSizes.spaceBtItems),
                    OrderInfoRow(
                      icon: Iconsax.card,
                      title: 'Payment Method',
                      value: order.paymentMethod,
                    ),
                    const SizedBox(height: CSizes.spaceBtItems),
                    OrderInfoRow(
                      icon: Iconsax.dollar_circle,
                      title: 'Total Amount',
                      value: '\$${order.totalAmount.toStringAsFixed(2)}',
                      isTotal: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: CSizes.spaceBtSections),

              /// -- Shipping Address
              const SectionHeading(
                title: 'Shipping Address',
                showActionButton: false,
              ),
              const SizedBox(height: CSizes.spaceBtItems),
              RoundedContainer(
                padding: const EdgeInsets.all(CSizes.md),
                showBorder: true,
                backgroundColor: dark ? CColors.dark : CColors.lightContainer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.address?.name ?? '',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: CSizes.spaceBtItems / 2),
                    Row(
                      children: [
                        const Icon(Icons.phone, color: Colors.grey, size: 16),
                        const SizedBox(width: CSizes.spaceBtItems / 2),
                        Text(
                          order.address?.formattedPhoneNo ?? '',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: CSizes.spaceBtItems / 2),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.grey,
                          size: 16,
                        ),
                        const SizedBox(width: CSizes.spaceBtItems / 2),
                        Expanded(
                          child: Text(
                            order.address?.toString() ?? 'No address provided.',
                            style: Theme.of(context).textTheme.bodyMedium,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: CSizes.spaceBtSections),

              /// -- Order Items
              const SectionHeading(
                title: 'Order Items',
                showActionButton: false,
              ),
              const SizedBox(height: CSizes.spaceBtItems),
              ListView.separated(
                separatorBuilder: (_, __) =>
                    const SizedBox(height: CSizes.spaceBtItems),
                itemCount: order.items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  final item = order.items[index];
                  // Use CCartItem to display the product info
                  return RoundedContainer(
                    showBorder: true,
                    padding: const EdgeInsets.all(CSizes.md),
                    backgroundColor: dark
                        ? CColors.dark
                        : CColors.lightContainer,
                    child: Column(
                      children: [
                        CCartItem(cartItem: item),
                        const SizedBox(height: CSizes.spaceBtItems),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Quantity:',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              item.quantity.toString(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Price:',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

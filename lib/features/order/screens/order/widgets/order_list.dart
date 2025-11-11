import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../../navigation_menu.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../controllers/order_controller.dart';
import '../../order_details/order_details.dart';

class COrderList extends StatelessWidget {
  const COrderList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    bool dark = context.isDarkMode;

    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (_, snapshot) {
        final emptyWidget = CAnimationLoaderWidget(
          text: 'Whoops! No Orders Yet!',
          animation: CImages.orderDelivery,
          showAction: true,
          actionText: 'Let\'s fill it',
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );

        final response = CloudHelperFunctions.checkMultiRecordState(
          snapshot: snapshot,
          nothingFound: emptyWidget,
        );
        if (response != null) return response;

        final orders = snapshot.data!;
        return ListView.separated(
          shrinkWrap: true,
          itemCount: orders.length,
          separatorBuilder: (_, index) =>
              const SizedBox(height: CSizes.spaceBtItems),
          itemBuilder: (_, index) {
            final order = orders[index];
            return RoundedContainer(
              showBorder: true,
              padding: EdgeInsets.all(CSizes.md),
              backgroundColor: dark ? CColors.dark : CColors.lightContainer,
              child: Column(
                children: [
                  Row(
                    children: [
                      /// 1 - Icon
                      Icon(
                        Iconsax.ship,
                        color: dark ? CColors.white : CColors.black,
                      ),
                      SizedBox(width: CSizes.spaceBtItems / 2),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.orderStatusText,
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .apply(
                                    color: CColors.primary,
                                    fontWeightDelta: 1,
                                  ),
                            ),
                            Text(
                              order.formattedOrderDate,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),

                      /// 3 - Icon
                      IconButton(
                        onPressed: () =>
                            Get.to(() => OrderDetailsScreen(order: order)),
                        icon: Icon(Iconsax.arrow_right_34, size: CSizes.iconSm),
                      ),
                    ],
                  ),
                  const SizedBox(height: CSizes.spaceBtItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          /// Icon
                          Icon(
                            Iconsax.tag,
                            color: dark ? CColors.white : CColors.black,
                          ),
                          SizedBox(width: CSizes.spaceBtItems / 2),

                          /// Status
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                order.id,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: CSizes.spaceBtItems / 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ///Icon
                          Icon(
                            Iconsax.calendar,
                            color: dark ? CColors.white : CColors.black,
                          ),
                          SizedBox(width: CSizes.spaceBtItems / 2),

                          ///Status
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shipping Date',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                order.formattedDeliveryDate,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

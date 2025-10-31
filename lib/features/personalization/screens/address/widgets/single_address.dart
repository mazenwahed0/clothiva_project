import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/address_controller.dart';
import '../../../models/address_model.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({super.key, required this.address, required this.onTap});

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;

    bool dark = context.isDarkMode || context.isDarkModeMedia;

    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;
      return InkWell(
        onTap: onTap,
        child: RoundedContainer(
          showBorder: true,
          padding: const EdgeInsets.all(CSizes.md),
          width: double.infinity,
          backgroundColor: selectedAddress
              ? CColors.primary.withOpacity(0.5)
              : Colors.transparent,
          borderColor: selectedAddress
              ? Colors.transparent
              : dark
              ? CColors.darkerGrey
              : CColors.grey,
          margin: const EdgeInsets.only(bottom: CSizes.spaceBtItems),
          child: Stack(
            children: [
              if (selectedAddress)
                Positioned(
                  right: 5,
                  top: 0,
                  child: Icon(
                    Iconsax.tick_circle5,
                    color: dark ? CColors.lightContainer : CColors.dark,
                  ),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: CSizes.sm / 2),
                  Text(
                    address.formattedPhoneNo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: CSizes.sm / 2),
                  Text(address.toString(), softWrap: true),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

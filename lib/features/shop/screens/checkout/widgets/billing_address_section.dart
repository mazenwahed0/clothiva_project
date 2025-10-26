import 'package:clothiva_project/features/personalization/controllers/address_controller.dart';
import 'package:flutter/material.dart';
import 'package:clothiva_project/common/widgets/texts/section_heading.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:get/get.dart';

class CBillingAddressSection extends StatelessWidget {
  const CBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () =>
              addressController.selectNewAddressPopup(context),
        ),
        const SizedBox(height: CSizes.spaceBtItems),

        Obx(() {
          final address = addressController.selectedAddress.value;
          if (address.id.isEmpty) {
            return Text('Select Address',
                style: Theme.of(context).textTheme.bodyMedium);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address.name,
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: CSizes.spaceBtItems / 2),
              Row(
                children: [
                  const Icon(Icons.phone, color: Colors.grey, size: 16),
                  const SizedBox(width: CSizes.spaceBtItems / 2),
                  Text(address.phoneNumber,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              const SizedBox(height: CSizes.spaceBtItems / 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on,
                      color: Colors.grey, size: 16),
                  const SizedBox(width: CSizes.spaceBtItems / 2),
                  Expanded(
                    child: Text(
                      '${address.street}, '
                      '${address.city}, '
                      '${address.state}, '
                      '${address.country}',
                      style: Theme.of(context).textTheme.bodyMedium,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ],
    );
  }
}

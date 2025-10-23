import 'package:flutter/material.dart';
import 'package:clothiva_project/common/widgets/texts/section_heading.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';

class CBillingAddressSection extends StatelessWidget {
  const CBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(title: 'Payment Method', buttonTitle: 'Change', onPressed: () {},),
        Text('Coding With T', style: Theme.of(context).textTheme.bodyLarge,),
        Row(
          children: [
            const Icon(Icons.phone, color: Colors.grey, size: 16,),
            const SizedBox(width: CSizes.spaceBtItems,),
            Text('+92-317-8059525', style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
        const SizedBox(height: CSizes.spaceBtItems / 2,),
        Row(
          children: [
            const Icon(Icons.location_history, color: Colors.grey, size: 16,),
            const SizedBox(width: CSizes.spaceBtItems,),
            Expanded(child: Text('South Liana, Maine 87695, USA', style: Theme.of(context).textTheme.bodyMedium, softWrap: true,)),
          ],
        ),
        const SizedBox(height: CSizes.spaceBtItems / 2,)
      ],
    );
  }
}
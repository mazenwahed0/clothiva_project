import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';


class CRatingAndShare extends StatelessWidget {
  const CRatingAndShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Iconsax.star5,
              color: Colors.amber,
              size: 24,
            ),
            const SizedBox(width: CSizes.spaceBtItems / 2),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "5.0",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const TextSpan(text: "(199)"),
                ],
              ),
            ),
          ],
        ),

        // Share Icon
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.share, size: CSizes.iconMd),
        ),
      ],
    );
  }
}
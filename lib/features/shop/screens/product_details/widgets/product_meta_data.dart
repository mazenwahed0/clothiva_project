import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/helpers/helper_functions.dart';


class CProductMetaData extends StatelessWidget{
  const CProductMetaData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = CHelperFunctions.isDarkMode(context);
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price & Sale
        Row(
          children: [
            // Sale Tag

          ],
        ),
      ],
    );
  }
}



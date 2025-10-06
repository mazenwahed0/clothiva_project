import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CProductMetaData extends StatelessWidget {
  const CProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = context.isDarkMode || context.isDarkModeMedia;
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

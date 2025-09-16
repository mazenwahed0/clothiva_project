import '/utils/constants/image_strings.dart';
import '/utils/constants/texts_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(CSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///MARK: Image
            Image(
              image: AssetImage(CImages.resetEmail),
              width: CHelperFunctions.screenWidth() * 0.6,
            ),

            ///MARK: Title & Subtitle
            Text(
              CTexts.changeYourPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: CSizes.spaceBtItems,
            ),
            Text(
              CTexts.changeYourPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),

            const SizedBox(
              height: CSizes.spaceBtSections,
            ),

            ///MARK: Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {}, child: Text(CTexts.done)),
            ),

            SizedBox(
              width: double.infinity,
              child: TextButton(
                  onPressed: () {}, child: Text(CTexts.resendEmail1)),
            ),
          ],
        ),
      ),
    );
  }
}

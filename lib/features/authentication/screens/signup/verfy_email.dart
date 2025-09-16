import '/common/widgets/success_signup_screen/success_signup_screen.dart';
import '/features/authentication/screens/login/login.dart';
import '/utils/constants/image_strings.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/texts_strings.dart';
import '/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerfyEmailScreen extends StatelessWidget {
  const VerfyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Note: To remove the back arrow
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Get.offAll(() => LoginScreen());
              },
              icon: Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              ///Image
              Image(
                image: AssetImage(CImages.verifyEmail),
                width: CHelperFunctions.screenWidth() * 0.6,
              ),

              ///Title & Subtitle
              Text(
                CTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: CSizes.spaceBtItems,
              ),
              Text(
                'admin@admin.com',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: CSizes.spaceBtItems,
              ),
              Text(
                CTexts.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(
                height: CSizes.spaceBtSections,
              ),

              ///Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => SuccessSignupScreen(
                            image: CImages.accountCreated,
                            title: CTexts.yourAccountCreatedTitle,
                            subTitle: CTexts.yourAccountCreatedSubTitle,
                            onPressed: () {
                              Get.to(() => LoginScreen());
                            },
                          ));
                    },
                    child: Text(CTexts.continueBtn)),
              ),
              const SizedBox(
                height: CSizes.spaceBtItems,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () {}, child: Text(CTexts.resendEmail1)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

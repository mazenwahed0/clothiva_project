// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../features/authentication/controllers/login/login_controller.dart';
// import '../../../features/authentication/screens/phone_number/phone_number_screen.dart';
// import '../../../utils/constants/colors.dart';
// import '../../../utils/constants/image_strings.dart';
// import '../../../utils/constants/sizes.dart';
// import '../../../utils/constants/text_strings.dart';
// import '../buttons/clickable_richtext_widget.dart';
// import '../buttons/primary_button.dart';

// class SocialFooter extends StatelessWidget {
//   const SocialFooter(
//       {super.key,
//       this.text1 = CTexts.dontHaveAnAccount,
//       this.text2 = CTexts.signup,
//       required this.onPressed});

//   final String text1, text2;
//   final VoidCallback onPressed;

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(LoginController());
//     return Container(
//       padding: const EdgeInsets.only(
//           top: CSizes.defaultSpace * 1.5, bottom: CSizes.defaultSpace),
//       child: Column(
//         children: [
//           Obx(
//             () => TPrimaryButton(
//               isLoading: controller.isLoading.value ? true : false,
//               text: '${CTexts.connectWith.tr} ${CTexts.phoneNumber.tr}',
//               onPressed:
//                   controller.isGoogleLoading.value || controller.isLoading.value
//                       ? () {}
//                       : controller.isFacebookLoading.value
//                           ? () {}
//                           // : () => controller.facebookSignIn(),
//                           : () => Get.to(() => const PhoneNumberScreen()),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Obx(
//             () => SocialButton(
//                 image: CImages.google,
//                 background: CColors.googleBackgroundColor,
//                 foreground: CColors.googleForegroundColor,
//                 text: '${CTexts.connectWith.tr} ${CTexts.google.tr}',
//                 isLoading: controller.isGoogleLoading.value ? true : false,
//                 onPressed: () {}
//                 // controller.isFacebookLoading.value || controller.isLoading.value
//                 //     ? () {}
//                 //     : controller.isGoogleLoading.value
//                 //     ? () {}
//                 //     : () => controller.googleSignIn(),
//                 ),
//           ),
//           // const SizedBox(height: 10),
//           // Obx(
//           //   () => TSocialButton(
//           //     image: TImages.tFacebookLogo,
//           //     foreground: TColors.white,
//           //     background: TColors.iconPrimaryLight,
//           //     text: '${TTexts.tConnectWith.tr} ${TTexts.tPhoneNumber.tr}',
//           //     isLoading: controller.isFacebookLoading.value ? true : false,
//           //     onPressed:
//           //         controller.isGoogleLoading.value || controller.isLoading.value
//           //             ? () {}
//           //             : controller.isFacebookLoading.value
//           //             ? () {}
//           //             // : () => controller.facebookSignIn(),
//           //             : () => Get.to(() => const PhoneNumberScreen()),
//           //   ),
//           // ),
//           const SizedBox(height: CSizes.defaultSpace * 2),
//           ClickableRichTextWidget(
//               text1: text1.tr, text2: text2.tr, onPressed: onPressed),
//         ],
//       ),
//     );
//   }
// }

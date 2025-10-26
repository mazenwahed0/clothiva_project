import 'package:clothiva_project/common/widgets/texts/section_heading.dart';
import 'package:clothiva_project/features/shop/models/payment_method_model.dart';
import 'package:clothiva_project/features/shop/models/payment_tile.dart';
import 'package:clothiva_project/utils/constants/image_strings.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(name: 'Paypal', image: CImages.paypal,);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {

    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(CSizes.lg),
          child: Column(
            children: [
              SectionHeading(title: 'Select Payment Method', showActionButton: false,),
              SizedBox(height: CSizes.spaceBtSections,),
              TPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paypal', image: CImages.paypal)),
              const SizedBox(height: CSizes.spaceBtItems/2,),
              TPaymentTile(paymentMethod: PaymentMethodModel(name: 'Google Pay', image: CImages.googlePay)),
              const SizedBox(height: CSizes.spaceBtItems/2,),
              TPaymentTile(paymentMethod: PaymentMethodModel(name: 'Apple Pay', image: CImages.applePay)),
              const SizedBox(height: CSizes.spaceBtItems/2,),
              TPaymentTile(paymentMethod: PaymentMethodModel(name: 'VISA', image: CImages.visa)),
              const SizedBox(height: CSizes.spaceBtItems/2,),
              TPaymentTile(paymentMethod: PaymentMethodModel(name: 'Master Card', image: CImages.masterCard)),
              const SizedBox(height: CSizes.spaceBtItems/2,),
              TPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paytm', image: CImages.paytm)),
              const SizedBox(height: CSizes.spaceBtItems/2,),
              TPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paystack', image: CImages.paystack)),
              const SizedBox(height: CSizes.spaceBtItems/2,),
              TPaymentTile(paymentMethod: PaymentMethodModel(name: 'Credit Card', image: CImages.creditCard)),
              const SizedBox(height: CSizes.spaceBtItems/2,),
              SizedBox(height: CSizes.spaceBtSections,),
            ],
          ),
        ),
      )
      );
  }

}
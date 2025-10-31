import '../../../utils/constants/enums.dart';

class PaymentMethodModel {
  String name;
  String image;
  PaymentMethods paymentMethod;

  PaymentMethodModel({
    required this.name,
    required this.image,
    this.paymentMethod = PaymentMethods.creditCard,
  });

  static PaymentMethodModel empty() => PaymentMethodModel(
      name: '', image: '', paymentMethod: PaymentMethods.creditCard);
}

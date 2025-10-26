import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'cart_item_model.dart';
import '../../personalization/models/address_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final Orderstatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    this.userId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    this.paymentMethod = '',
    this.address,
    this.deliveryDate,
  });

  String get formattedOrderDate => CHelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate =>
      CHelperFunctions.getFormattedDate(deliveryDate!);

  String get orderStatusText => status == Orderstatus.delivered
      ? 'Delivered'
      : status == Orderstatus.pending
      ? 'Pending'
      : status == Orderstatus.processing
      ? 'Processing'
      : status == Orderstatus.shipped
      ? 'Shipment on the way'
      : 'Processing';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(), // Enum to string
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'address': address?.toJson(), // convert address model to map
      'deliveryDate': deliveryDate,
      'items': items
          .map((item) => item.toJson())
          .toList(), // convert CartItemModel to map
    };
  }

  // factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
  //   final data = snapshot.data() as Map<String, dynamic>;

  //   return OrderModel(
  //     id: data['id'] as String,
  //     userId: data['userId'] as String,
  //     status: Orderstatus.values
  //         .firstWhere((element) => element.toString() == data['status']),
  //     totalAmount: data['totalAmount'] as double,
  //     orderDate: (data['orderDate'] as Timestamp).toDate(),
  //     paymentMethod: data['paymentMethod'] as String,
  //     address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
  //     deliveryDate: (data.containsKey('deliveryDate') &&
  //             data['deliveryDate'] is Timestamp)
  //         ? (data['deliveryDate'] as Timestamp).toDate()
  //         : null,
  //     items: (data['items'] as List<dynamic>)
  //         .map(
  //           (itemData) =>
  //               CartItemModel.fromJson(itemData as Map<String, dynamic>),
  //         )
  //         .toList(),
  //   );
  // }

  //CG
  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
      id: data['id'] is String && (data['id'] as String).isNotEmpty
          ? data['id'] as String
          : snapshot.id,
      userId: data['userId'] as String? ?? '',
      status: Orderstatus.values.firstWhere(
        (element) => element.toString() == data['status'],
        orElse: () => Orderstatus.pending,
      ),
      totalAmount: (data['totalAmount'] as num).toDouble(),
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      paymentMethod: data['paymentMethod'] as String? ?? '',
      address: data['address'] != null
          ? AddressModel.fromMap(data['address'] as Map<String, dynamic>)
          : null,
      deliveryDate:
          (data.containsKey('deliveryDate') &&
              data['deliveryDate'] is Timestamp)
          ? (data['deliveryDate'] as Timestamp).toDate()
          : null,
      items:
          (data['items'] as List<dynamic>?)
              ?.map(
                (itemData) =>
                    CartItemModel.fromJson(itemData as Map<String, dynamic>),
              )
              .toList() ??
          <CartItemModel>[],
    );
  }
}

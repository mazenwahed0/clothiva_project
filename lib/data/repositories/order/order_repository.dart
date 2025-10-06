// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// import '../../../features/cart/models/order_model.dart';
// import '../../../utils/constants/keys.dart';
// import '../authentication/authentication_repository.dart';

// class OrderRepository extends GetxController {
//   static OrderRepository get instance => Get.find();

//   /// Variables
//   final _db = FirebaseFirestore.instance;
//   final _auth = AuthenticationRepository.instance;

//   /// [Save] - Save user Order
//   Future<void> saveOrder(OrderModel order) async {
//     try {
//       await _db
//           .collection(CKeys.userCollection)
//           .doc(order.userId)
//           .collection(CKeys.ordersCollection)
//           .add(order.toJson());
//     } catch (e) {
//       throw 'Something went wrong while saving order info';
//     }
//   }

//   /// [Fetch] - Fetch user orders
//   Future<List<OrderModel>> fetchUserOrders() async {
//     try {
//       final userId = _auth.getUserID;
//       if (userId.isEmpty) throw 'Unable to find user information';

//       final query = await _db
//           .collection(CKeys.userCollection)
//           .doc(userId)
//           .collection(CKeys.ordersCollection)
//           .get();
//       if (query.docs.isNotEmpty) {
//         List<OrderModel> orders =
//             query.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
//         return orders;
//       }

//       return [];
//     } catch (e) {
//       throw 'Something went wrong while order info';
//     }
//   }
// }

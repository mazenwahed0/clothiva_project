import 'package:cloud_firestore/cloud_firestore.dart';

class WishlistModel {
  final String id;
  final String ownerId;
  final List<String> productIds;
  final List<String> sharedWith; // uids of collaborators who can view/edit
  final bool isShared;
  final DateTime updatedAt;
  final DateTime? createdAt;

  WishlistModel({
    required this.id,
    required this.ownerId,
    required this.productIds,
    this.sharedWith = const [],
    this.isShared = false,
    required this.updatedAt,
    this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'ownerId': ownerId,
        'productIds': productIds,
        'sharedWith': sharedWith,
        'isShared': isShared,
        'updatedAt': Timestamp.fromDate(updatedAt),
        if (createdAt != null) 'createdAt': Timestamp.fromDate(createdAt!),
      };

  factory WishlistModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? <String, dynamic>{};
    return WishlistModel(
      id: doc.id,
      ownerId: data['ownerId'] as String? ?? '',
      productIds: List<String>.from(data['productIds'] ?? []),
      sharedWith: List<String>.from(data['sharedWith'] ?? []),
      isShared: data['isShared'] as bool? ?? false,
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';

// class WishlistModel {
//   final String id;
//   final String ownerId;
//   final List<String> productIds;
//   final List<String> sharedWith; // uids of collaborators who can view/edit
//   final bool isShared;
//   final DateTime updatedAt;
//   final DateTime? createdAt;

//   WishlistModel({
//     required this.id,
//     required this.ownerId,
//     required this.productIds,
//     this.sharedWith = const [],
//     this.isShared = false,
//     required this.updatedAt,
//     this.createdAt,
//   });

//   Map<String, dynamic> toMap() => {
//         'ownerId': ownerId,
//         'productIds': productIds,
//         'sharedWith': sharedWith,
//         'isShared': isShared,
//         'updatedAt': Timestamp.fromDate(updatedAt),
//         if (createdAt != null) 'createdAt': Timestamp.fromDate(createdAt!),
//       };

//   factory WishlistModel.fromDoc(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>? ?? <String, dynamic>{};
//     return WishlistModel(
//       id: doc.id,
//       ownerId: data['ownerId'] as String? ?? '',
//       productIds: List<String>.from(data['productIds'] ?? []),
//       sharedWith: List<String>.from(data['sharedWith'] ?? []),
//       isShared: data['isShared'] as bool? ?? false,
//       updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
//       createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
//     );
//   }
// }

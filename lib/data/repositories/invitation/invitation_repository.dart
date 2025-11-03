import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/keys.dart';
import '../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../utils/exceptions/format_exceptions.dart';
import '../../../features/invitation/models/invitation_model.dart';
import '../../../utils/constants/enums.dart';
import '../wishlist/wishlist_repository.dart';

class InvitationRepository extends GetxController {
  static InvitationRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final wishlistRepo = WishlistRepository.instance;

  User? get _currentUser => _auth.currentUser;

  Future<void> sendInvite(String email) async {
    try {
      if (_currentUser == null) throw Exception("User not logged in.");

      // --- MODIFICATION ---
      // Removed check that blocked sending multiple invites.
      // An owner can now send as many invites as they want.
      // --- END MODIFICATION ---

      final userQuery = await _db
          .collection(CKeys.userCollection)
          .where('email', isEqualTo: email.toLowerCase().trim())
          .limit(1)
          .get();

      if (userQuery.docs.isEmpty) throw Exception("Recipient not found.");

      final recipientData = userQuery.docs.first.data();
      final recipientName =
          '${recipientData['firstName'] ?? ''} ${recipientData['lastName'] ?? ''}'
              .trim();

      final invite = Invitation(
        id: '',
        senderId: _currentUser!.uid,
        senderName: _currentUser!.displayName ?? 'Unknown User',
        recipientEmail: email.toLowerCase().trim(),
        recipientName: recipientName.isEmpty ? 'Unknown' : recipientName,
        status: InvitationStatus.pending,
        createdAt: DateTime.now(),
        shareEnabled: true,
      );

      await _db.collection(CKeys.inviteCollection).add(invite.toMap());
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw CFormatException();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> acceptInvite(String inviteId) async {
    try {
      if (_currentUser == null) throw Exception("User not logged in.");

      // --- MODIFICATION ---
      // Removed check that blocked joining multiple lists.
      // A user can now only be in one group, but we won't block
      // the accept. The logic is now: accept invite -> join group.
      // --- END MODIFICATION ---

      final ref = _db.collection(CKeys.inviteCollection).doc(inviteId);
      final snap = await ref.get();
      if (!snap.exists) throw Exception("Invitation not found.");

      final data = snap.data()!;
      final senderId = data['senderId'];

      await ref.update({
        'status': InvitationStatus.accepted.toString().split('.').last,
        'recipientId': _currentUser!.uid,
      });

      if (senderId != null) {
        await wishlistRepo.addCollaboratorToOwner(senderId, _currentUser!.uid);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> rejectInvite(String inviteId) async {
    try {
      // Deleting is cleaner than setting to 'rejected'
      await _db.collection(CKeys.inviteCollection).doc(inviteId).delete();
    } catch (e) {
      throw 'Failed to reject invite.';
    }
  }

  /// Removes the collaborator from the wishlist and deletes the invite
  Future<void> removeOrLeaveCollaboration(
    String inviteId,
    String ownerId,
    String recipientId,
  ) async {
    try {
      if (_currentUser == null) throw Exception("User not logged in.");

      // 1. Remove user from the Wishlist 'sharedWith' array
      await wishlistRepo.removeCollaboratorFromOwner(ownerId, recipientId);

      // 2. Delete the invitation document
      await _db.collection(CKeys.inviteCollection).doc(inviteId).delete();
    } catch (e) {
      throw 'Failed to remove collaboration.';
    }
  }

  Stream<List<Invitation>> fetchPendingInvitations() {
    final email = _currentUser?.email;
    if (email == null) return Stream.value([]);
    return _db
        .collection(CKeys.inviteCollection)
        .where('recipientEmail', isEqualTo: email.toLowerCase())
        .where(
          'status',
          isEqualTo: InvitationStatus.pending.toString().split('.').last,
        )
        .snapshots()
        .map((s) => s.docs.map((d) => Invitation.fromFirestore(d)).toList());
  }

  Stream<List<Invitation>> fetchSentInvitations() {
    final uid = _currentUser?.uid;
    if (uid == null) return Stream.value([]);
    return _db
        .collection(CKeys.inviteCollection)
        .where('senderId', isEqualTo: uid)
        .snapshots()
        .map((s) => s.docs.map((d) => Invitation.fromFirestore(d)).toList());
  }

  Stream<List<Invitation>> fetchCollaborators() {
    final uid = _currentUser?.uid;
    if (uid == null) return Stream.value([]);
    return _db
        .collection(CKeys.inviteCollection)
        .where(
          'status',
          isEqualTo: InvitationStatus.accepted.toString().split('.').last,
        )
        .where(
          Filter.or(
            Filter('senderId', isEqualTo: uid),
            Filter('recipientId', isEqualTo: uid),
          ),
        )
        .snapshots()
        .map((s) => s.docs.map((d) => Invitation.fromFirestore(d)).toList());
  }

  Future<void> updateShareStatus(String inviteId, bool shareMode) async {
    try {
      if (_currentUser == null) throw Exception("User not logged in.");

      final ref = _db.collection(CKeys.inviteCollection).doc(inviteId);
      final snap = await ref.get();
      if (!snap.exists) throw Exception("Invitation not found.");

      final data = snap.data()!;
      final senderId = data['senderId'];
      final isOwner = _currentUser!.uid == senderId;

      if (!isOwner) {
        throw Exception("Only the owner can modify sharing settings.");
      }

      // 1. Update the 'master' invite document (used as a reference)
      await ref.update({'shareEnabled': shareMode});

      // 2. Update the wishlist document
      final wishlists = await _db
          .collection(CKeys.wishlistCollection)
          .where('ownerId', isEqualTo: _currentUser!.uid)
          .get();

      for (final doc in wishlists.docs) {
        await doc.reference.update({
          'isShared': shareMode,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }

      // 3. Update all *other* accepted invites for this owner
      final invites = await _db
          .collection(CKeys.inviteCollection)
          .where('senderId', isEqualTo: _currentUser!.uid)
          .where('status', isEqualTo: 'accepted')
          .get();

      for (final invite in invites.docs) {
        await invite.reference.update({'shareEnabled': shareMode});
      }
    } catch (e) {
      throw 'Failed to update sharing status.';
    }
  }
}
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import '../../../../utils/constants/keys.dart';
// import '../../../../utils/exceptions/firebase_exceptions.dart';
// import '../../../../utils/exceptions/format_exceptions.dart';
// import '../../../../utils/exceptions/platform_exceptions.dart';
// import '../../../features/invitation/models/invitation_model.dart';
// import '../wishlist/wishlist_repository.dart';

// class InvitationRepository extends GetxController {
//   static InvitationRepository get instance => Get.find();

//   final _db = FirebaseFirestore.instance;
//   final _auth = FirebaseAuth.instance;
//   final wishlistRepo = WishlistRepository.instance;

//   User? get _currentUser => _auth.currentUser;

//   Future<void> sendInvite(String email) async {
//     try {
//       if (_currentUser == null) throw Exception("User not logged in.");

//       final userQuery = await _db
//           .collection(CKeys.userCollection)
//           .where('email', isEqualTo: email.toLowerCase().trim())
//           .limit(1)
//           .get();

//       if (userQuery.docs.isEmpty) throw Exception("Recipient not found.");

//       final recipientData = userQuery.docs.first.data();
//       final recipientName =
//           '${recipientData['firstName'] ?? ''} ${recipientData['lastName'] ?? ''}'
//               .trim();

//       final invite = Invitation(
//         id: '',
//         senderId: _currentUser!.uid,
//         senderName: _currentUser!.displayName ?? 'Unknown User',
//         recipientEmail: email.toLowerCase().trim(),
//         recipientName: recipientName.isEmpty ? 'Unknown' : recipientName,
//         status: InvitationStatus.pending,
//         createdAt: DateTime.now(),
//         shareEnabled: true,
//       );

//       await _db.collection(CKeys.inviteCollection).add(invite.toMap());
//     } on FirebaseException catch (e) {
//       throw CFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw CFormatException();
//     } catch (e) {
//       throw 'Failed to send invite.';
//     }
//   }

//   Future<void> acceptInvite(String inviteId) async {
//     try {
//       if (_currentUser == null) throw Exception("User not logged in.");

//       final ref = _db.collection(CKeys.inviteCollection).doc(inviteId);
//       final snap = await ref.get();
//       if (!snap.exists) throw Exception("Invitation not found.");

//       final data = snap.data()!;
//       final senderId = data['senderId'];

//       await ref.update({
//         'status': InvitationStatus.accepted.toString().split('.').last,
//         'recipientId': _currentUser!.uid,
//       });

//       if (senderId != null) {
//         await wishlistRepo.addCollaboratorToOwner(senderId, _currentUser!.uid);
//       }
//     } catch (e) {
//       throw 'Failed to accept invite.';
//     }
//   }

//   Future<void> rejectInvite(String inviteId) async {
//     try {
//       await _db.collection(CKeys.inviteCollection).doc(inviteId).update({
//         'status': InvitationStatus.rejected.toString().split('.').last,
//       });
//     } catch (e) {
//       throw 'Failed to reject invite.';
//     }
//   }

//   Stream<List<Invitation>> fetchPendingInvitations() {
//     final email = _currentUser?.email;
//     if (email == null) return Stream.value([]);
//     return _db
//         .collection(CKeys.inviteCollection)
//         .where('recipientEmail', isEqualTo: email.toLowerCase())
//         .where('status',
//             isEqualTo: InvitationStatus.pending.toString().split('.').last)
//         .snapshots()
//         .map((s) => s.docs.map((d) => Invitation.fromFirestore(d)).toList());
//   }

//   Stream<List<Invitation>> fetchSentInvitations() {
//     final uid = _currentUser?.uid;
//     if (uid == null) return Stream.value([]);
//     return _db
//         .collection(CKeys.inviteCollection)
//         .where('senderId', isEqualTo: uid)
//         .snapshots()
//         .map((s) => s.docs.map((d) => Invitation.fromFirestore(d)).toList());
//   }

//   Stream<List<Invitation>> fetchCollaborators() {
//     final uid = _currentUser?.uid;
//     if (uid == null) return Stream.value([]);
//     return _db
//         .collection(CKeys.inviteCollection)
//         .where('status',
//             isEqualTo: InvitationStatus.accepted.toString().split('.').last)
//         .where(Filter.or(
//           Filter('senderId', isEqualTo: uid),
//           Filter('recipientId', isEqualTo: uid),
//         ))
//         .snapshots()
//         .map((s) => s.docs.map((d) => Invitation.fromFirestore(d)).toList());
//   }

//   // Future<void> updateShareStatus(String inviteId, bool shareMode) async {
//   //   try {
//   //     if (_currentUser == null) throw Exception("User not logged in.");

//   //     final ref = _db.collection(CKeys.inviteCollection).doc(inviteId);
//   //     final snap = await ref.get();
//   //     if (!snap.exists) throw Exception("Invitation not found.");

//   //     final data = snap.data()!;
//   //     final senderId = data['senderId'];
//   //     final recipientId = data['recipientId'];
//   //     final currentShare = data['shareEnabled'] ?? true;

//   //     final isOwner = _currentUser!.uid == senderId;
//   //     final isRecipient = _currentUser!.uid == recipientId;

//   //     if (isRecipient && !currentShare) {
//   //       throw Exception("Owner disabled sharing. You can’t override it.");
//   //     }

//   //     await ref.update({'shareEnabled': shareMode});

//   //     if (isOwner) {
//   //       final wishlists = await _db
//   //           .collection(CKeys.wishlistCollection)
//   //           .where('ownerId', isEqualTo: _currentUser!.uid)
//   //           .get();

//   //       for (final doc in wishlists.docs) {
//   //         await doc.reference.update({'isShared': shareMode});
//   //         if (!shareMode) await doc.reference.update({'sharedWith': []});
//   //       }
//   //     }
//   //   } catch (e) {
//   //     throw 'Failed to update sharing status.';
//   //   }
//   // }

//   Future<void> updateShareStatus(String inviteId, bool shareMode) async {
//     try {
//       if (_currentUser == null) throw Exception("User not logged in.");

//       final ref = _db.collection(CKeys.inviteCollection).doc(inviteId);
//       final snap = await ref.get();
//       if (!snap.exists) throw Exception("Invitation not found.");

//       final data = snap.data()!;
//       final senderId = data['senderId'];
//       final recipientId = data['recipientId'];
//       final currentShare = data['shareEnabled'] ?? true;

//       final isOwner = _currentUser!.uid == senderId;
//       final isRecipient = _currentUser!.uid == recipientId;

//       // 🚫 Prevent recipient from modifying sharing
//       if (isRecipient) {
//         throw Exception("Only the owner can modify sharing settings.");
//       }

//       // ✅ Owner can always toggle
//       await ref.update({'shareEnabled': shareMode});

//       if (isOwner) {
//         final wishlists = await _db
//             .collection(CKeys.wishlistCollection)
//             .where('ownerId', isEqualTo: _currentUser!.uid)
//             .get();

//         for (final doc in wishlists.docs) {
//           await doc.reference.update({
//             'isShared': shareMode,
//             'updatedAt': FieldValue.serverTimestamp(),
//           });
//         }

//         // 🧠 Also update all recipient invites for this owner
//         final invites = await _db
//             .collection(CKeys.inviteCollection)
//             .where('senderId', isEqualTo: _currentUser!.uid)
//             .where('status', isEqualTo: 'accepted')
//             .get();

//         for (final invite in invites.docs) {
//           await invite.reference.update({
//             'shareEnabled': shareMode,
//             // if turned off, force recipient local
//             if (!shareMode) 'recipientShareMode': false,
//           });
//         }
//       }

      // // Update all wishlists for the owner
      // if (isOwner) {
      //   final wishlists = await _db
      //       .collection(CKeys.wishlistCollection)
      //       .where('ownerId', isEqualTo: _currentUser!.uid)
      //       .get();

      //   for (final doc in wishlists.docs) {
      //     await doc.reference.update({
      //       'isShared': shareMode,
      //       // 👇 Keep sharedWith list, just flip flag
      //       'updatedAt': FieldValue.serverTimestamp(),
      //     });
      //   }

      //   // 👇 Update all invites for this owner instead of removing collaborators
      //   final invites = await _db
      //       .collection(CKeys.inviteCollection)
      //       .where('senderId', isEqualTo: _currentUser!.uid)
      //       .where('status', isEqualTo: 'accepted')
      //       .get();

      //   for (final invite in invites.docs) {
      //     await invite.reference.update({'shareEnabled': shareMode});
      //   }
      // }
//     } catch (e) {
//       throw 'Failed to update sharing status.';
//     }
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// import '../../../../utils/constants/keys.dart';
// import '../../../../utils/exceptions/firebase_exceptions.dart';
// import '../../../../utils/exceptions/format_exceptions.dart';
// import '../../../../utils/exceptions/platform_exceptions.dart';
// import '../../../features/invitation/models/invitation_model.dart';
// import '../../../utils/popups/loaders.dart';
// import '../wishlist/wishlist_repository.dart';

// class InvitationRepository extends GetxController {
//   static InvitationRepository get instance => Get.find();

//   /// Firestore & Auth references
//   final _db = FirebaseFirestore.instance;
//   final _auth = FirebaseAuth.instance;
//   final wishlistRepo = WishlistRepository.instance;

//   User? get _currentUser => _auth.currentUser;

//   /// [SendInvite] - Send a new invitation to collaborate
//   Future<void> sendInvite(String email) async {
//     try {
//       if (_currentUser == null) throw Exception("User not logged in.");

//       // Find recipient user in Firestore
//       final userQuery = await _db
//           .collection(CKeys.userCollection)
//           .where('email', isEqualTo: email.toLowerCase().trim())
//           .limit(1)
//           .get();

//       if (userQuery.docs.isEmpty) {
//         throw Exception("Recipient not found.");
//       }

//       final recipientData = userQuery.docs.first.data();
//       final recipientName =
//           '${recipientData['firstName'] ?? ''} ${recipientData['lastName'] ?? ''}'
//                   .trim()
//                   .isEmpty
//               ? 'Unknown'
//               : '${recipientData['firstName']} ${recipientData['lastName']}'
//                   .trim();

//       final newInvitation = Invitation(
//         id: '',
//         senderId: _currentUser!.uid,
//         senderName: _currentUser!.displayName ?? 'Unknown User',
//         recipientEmail: email.toLowerCase().trim(),
//         recipientName: recipientName,
//         status: InvitationStatus.pending,
//         createdAt: DateTime.now(),
//         shareEnabled: true,
//       );

//       // Add the invitation document to Firestore
//       await _db.collection(CKeys.inviteCollection).add(newInvitation.toMap());
//     } on FirebaseException catch (e) {
//       throw CFirebaseException(e.code).message;
//     } on PlatformException catch (e) {
//       throw CPlatformException(e.code).message;
//     } on FormatException catch (_) {
//       throw CFormatException();
//     } catch (e) {
//       throw 'Something went wrong while sending the invite.';
//     }
//   }

//   /// [AcceptInvite] - Accept an invitation
//   Future<void> acceptInvite(String inviteId) async {
//     try {
//       if (_currentUser == null) throw Exception("User not logged in.");

//       final inviteRef = _db.collection(CKeys.inviteCollection).doc(inviteId);
//       final inviteSnap = await inviteRef.get();
//       if (!inviteSnap.exists) throw Exception('Invitation not found.');

//       final inviteData = inviteSnap.data()!;
//       final senderId = inviteData['senderId'] as String?;

//       await inviteRef.update({
//         'status': InvitationStatus.accepted.toString().split('.').last,
//         'recipientId': _currentUser!.uid,
//       });

//       // add collaborator to sender's wishlist (create if missing)
//       if (senderId != null && senderId.isNotEmpty) {
//         await wishlistRepo.addCollaboratorToOwner(senderId, _currentUser!.uid);
//       }
//     } on FirebaseException catch (e) {
//       throw CFirebaseException(e.code).message;
//     } on PlatformException catch (e) {
//       throw CPlatformException(e.code).message;
//     } on FormatException catch (_) {
//       throw CFormatException();
//     } catch (e) {
//       throw 'Something went wrong while accepting the invite.';
//     }
//   }
//   // Future<void> acceptInvite(String inviteId) async {
//   //   try {
//   //     if (_currentUser == null) throw Exception("User not logged in.");

//   //     await _db.collection(CKeys.inviteCollection).doc(inviteId).update({
//   //       'status': InvitationStatus.accepted.toString().split('.').last,
//   //       'recipientId': _currentUser!.uid,
//   //     });
//   //   } on FirebaseException catch (e) {
//   //     throw CFirebaseException(e.code).message;
//   //   } on PlatformException catch (e) {
//   //     throw CPlatformException(e.code).message;
//   //   } on FormatException catch (_) {
//   //     throw CFormatException();
//   //   } catch (e) {
//   //     throw 'Something went wrong while accepting the invite.';
//   //   }
//   // }

//   /// [RejectInvite] - Reject an invitation
//   Future<void> rejectInvite(String inviteId) async {
//     try {
//       await _db.collection(CKeys.inviteCollection).doc(inviteId).update({
//         'status': InvitationStatus.rejected.toString().split('.').last,
//       });
//     } on FirebaseException catch (e) {
//       throw CFirebaseException(e.code).message;
//     } on PlatformException catch (e) {
//       throw CPlatformException(e.code).message;
//     } on FormatException catch (_) {
//       throw CFormatException();
//     } catch (e) {
//       throw 'Something went wrong while rejecting the invite.';
//     }
//   }

//   /// [FetchPendingInvitations] - Stream of pending invites for current user
//   Stream<List<Invitation>> fetchPendingInvitations() {
//     try {
//       final userEmail = _currentUser?.email;
//       if (userEmail == null) return Stream.value([]);

//       return _db
//           .collection(CKeys.inviteCollection)
//           .where('recipientEmail', isEqualTo: userEmail.toLowerCase().trim())
//           .where(
//             'status',
//             isEqualTo: InvitationStatus.pending.toString().split('.').last,
//           )
//           .snapshots()
//           .map((snapshot) => snapshot.docs
//               .map((doc) => Invitation.fromFirestore(doc))
//               .toList());
//     } catch (e) {
//       rethrow;
//     }
//   }

//   /// [FetchSentInvitations] - Stream of invites sent by the current user
//   Stream<List<Invitation>> fetchSentInvitations() {
//     try {
//       final currentUserId = _currentUser?.uid;
//       if (currentUserId == null) return Stream.value([]);

//       return _db
//           .collection(CKeys.inviteCollection)
//           .where('senderId', isEqualTo: currentUserId)
//           .snapshots()
//           .map((snapshot) => snapshot.docs
//               .map((doc) => Invitation.fromFirestore(doc))
//               .toList());
//     } catch (e) {
//       rethrow;
//     }
//   }

//   /// [FetchCollaborators] - Stream of accepted collaborators
//   Stream<List<Invitation>> fetchCollaborators() {
//     try {
//       final currentUserId = _currentUser?.uid;
//       if (currentUserId == null) return Stream.value([]);

//       return _db
//           .collection(CKeys.inviteCollection)
//           .where(
//             'status',
//             isEqualTo: InvitationStatus.accepted.toString().split('.').last,
//           )
//           .where(
//             Filter.or(
//               Filter('senderId', isEqualTo: currentUserId),
//               Filter('recipientId', isEqualTo: currentUserId),
//             ),
//           )
//           .snapshots()
//           .map((snapshot) => snapshot.docs
//               .map((doc) => Invitation.fromFirestore(doc))
//               .toList());
//     } catch (e) {
//       rethrow;
//     }
//   }

//   /// [UpdateShareStatus] - Enable or disable sharing
//   Future<void> updateShareStatus(String inviteId, bool shareMode) async {
//     try {
//       final user = _currentUser;
//       if (user == null) throw Exception("User not logged in.");

//       final inviteRef = _db.collection(CKeys.inviteCollection).doc(inviteId);
//       final inviteSnap = await inviteRef.get();
//       if (!inviteSnap.exists) throw Exception("Invitation not found.");

//       final inviteData = inviteSnap.data()!;
//       final senderId = inviteData['senderId'];
//       final recipientId = inviteData['recipientId'];
//       final currentShareEnabled = inviteData['shareEnabled'] ?? true;

//       // 🧠 Determine role
//       final isOwner = user.uid == senderId;
//       final isRecipient = user.uid == recipientId;

//       if (isRecipient && !currentShareEnabled) {
//         // Recipient can't override Owner
//         Loaders.warningSnackBar(
//           title: "Sharing Disabled",
//           message:
//               "The owner disabled sharing. You can only use your local wishlist.",
//         );
//         return;
//       }

//       // 🧩 Update the invitation doc
//       await inviteRef.update({'shareEnabled': shareMode});

//       // 🔄 Owner’s control syncs with wishlist sharing
//       if (isOwner) {
//         final wishlists = await _db
//             .collection(CKeys.wishlistCollection)
//             .where('ownerId', isEqualTo: user.uid)
//             .get();

//         for (final doc in wishlists.docs) {
//           await doc.reference.update({'isShared': shareMode});
//         }

//         // If disabled, also remove collaborators' access
//         if (!shareMode) {
//           for (final doc in wishlists.docs) {
//             await doc.reference.update({'sharedWith': []});
//           }
//         }
//       }
//     } on FirebaseException catch (e) {
//       throw CFirebaseException(e.code).message;
//     } on PlatformException catch (e) {
//       throw CPlatformException(e.code).message;
//     } on FormatException catch (_) {
//       throw CFormatException();
//     } catch (e) {
//       throw 'Failed to update sharing status.';
//     }
//   }

//   // Future<void> updateShareStatus(String inviteId, bool shareMode) async {
//   //   try {
//   //     // Update the invitation document
//   //     await _db
//   //         .collection(CKeys.inviteCollection)
//   //         .doc(inviteId)
//   //         .update({'shareEnabled': shareMode});

//   //     //  Also update the corresponding wishlist for this user
//   //     final user = _currentUser;
//   //     if (user != null) {
//   //       final wishlists = await _db
//   //           .collection(CKeys.wishlistCollection)
//   //           .where('ownerId', isEqualTo: user.uid)
//   //           .get();

//   //       for (final doc in wishlists.docs) {
//   //         await doc.reference.update({'isShared': shareMode});
//   //       }
//   //     }
//   //   } on FirebaseException catch (e) {
//   //     throw CFirebaseException(e.code).message;
//   //   } on PlatformException catch (e) {
//   //     throw CPlatformException(e.code).message;
//   //   } on FormatException catch (_) {
//   //     throw CFormatException();
//   //   } catch (e) {
//   //     throw 'Failed to update sharing status.';
//   //   }
//   // }
// }

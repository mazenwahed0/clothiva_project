import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/keys.dart';
import '../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../utils/exceptions/format_exceptions.dart';
import '../../../../utils/exceptions/platform_exceptions.dart';
import '../../../features/shop/models/wishlist_model.dart';

class WishlistRepository extends GetxController {
  static WishlistRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  /// Returns a stream of the user's wishlist (owned or shared).
  Stream<WishlistModel?> getWishlistStream() {
    try {
      if (currentUser == null) return Stream.value(null);
      final uid = currentUser!.uid;

      return _db
          .collection(CKeys.wishlistCollection)
          .where(
            Filter.or(
              Filter('ownerId', isEqualTo: uid),
              Filter('sharedWith', arrayContains: uid),
            ),
          )
          .limit(1)
          .snapshots() // <-- Use .snapshots() to listen for real-time updates
          .map((snapshot) {
            if (snapshot.docs.isEmpty) return null;
            return WishlistModel.fromDoc(snapshot.docs.first);
          });
    } catch (e) {
      return Stream.error('Failed to listen to wishlist.');
    }
  }

  /// Returns the wishlist that the user either owns or is a collaborator of.
  /// If [forceOwner] = true → only fetch wishlists owned by the user.
  Future<WishlistModel?> getUserWishlist({bool forceOwner = false}) async {
    try {
      if (currentUser == null) return null;
      final uid = currentUser!.uid;

      QuerySnapshot query;

      if (forceOwner) {
        query = await _db
            .collection(CKeys.wishlistCollection)
            .where('ownerId', isEqualTo: uid)
            .limit(1)
            .get();
      } else {
        query = await _db
            .collection(CKeys.wishlistCollection)
            .where(
              Filter.or(
                Filter('ownerId', isEqualTo: uid),
                Filter('sharedWith', arrayContains: uid),
              ),
            )
            .limit(1)
            .get();
      }

      if (query.docs.isEmpty) return null;
      return WishlistModel.fromDoc(query.docs.first);
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw CFormatException();
    } catch (e) {
      throw 'Failed to fetch wishlist.';
    }
  }

  /// Toggle a product in the user's accessible wishlist.
  /// If none exists, create one owned by the current user.
  Future<void> toggleProduct(String productId) async {
    try {
      if (currentUser == null) throw Exception('User not logged in.');

      final wishlist = await getUserWishlist();
      if (wishlist == null) {
        await _createWishlistForOwner(currentUser!.uid, [productId]);
        return;
      }

      final docRef = _db.collection(CKeys.wishlistCollection).doc(wishlist.id);

      if (wishlist.productIds.contains(productId)) {
        await docRef.update({
          'productIds': FieldValue.arrayRemove([productId]),
          'updatedAt': Timestamp.fromDate(DateTime.now()),
        });
      } else {
        await docRef.update({
          'productIds': FieldValue.arrayUnion([productId]),
          'updatedAt': Timestamp.fromDate(DateTime.now()),
        });
      }
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw CFormatException();
    } catch (e) {
      throw 'Failed to toggle wishlist product.';
    }
  }

  /// Create wishlist owned by `ownerId` with productIds
  Future<void> _createWishlistForOwner(
    String ownerId,
    List<String> productIds,
  ) async {
    try {
      await _db.collection(CKeys.wishlistCollection).add({
        'ownerId': ownerId,
        'productIds': productIds,
        'sharedWith': [],
        'isShared': false,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw CFormatException();
    } catch (e) {
      throw 'Failed to create wishlist.';
    }
  }

  /// Add a collaborator to an owner's wishlist (create wishlist if not exist)
  Future<void> addCollaboratorToOwner(
    String ownerId,
    String collaboratorId,
  ) async {
    try {
      final query = await _db
          .collection(CKeys.wishlistCollection)
          .where('ownerId', isEqualTo: ownerId)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        await _db.collection(CKeys.wishlistCollection).add({
          'ownerId': ownerId,
          'productIds': [],
          'sharedWith': [collaboratorId],
          'isShared': true,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      } else {
        final doc = query.docs.first;
        await _db.collection(CKeys.wishlistCollection).doc(doc.id).update({
          'sharedWith': FieldValue.arrayUnion([collaboratorId]),
          'isShared': true,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw CFormatException();
    } catch (e) {
      throw 'Failed to add collaborator to wishlist.';
    }
  }

  /// Remove collaborator from an owner's wishlist
  Future<void> removeCollaboratorFromOwner(
    String ownerId,
    String collaboratorId,
  ) async {
    try {
      final query = await _db
          .collection(CKeys.wishlistCollection)
          .where('ownerId', isEqualTo: ownerId)
          .limit(1)
          .get();

      if (query.docs.isEmpty) return;

      final docRef = _db
          .collection(CKeys.wishlistCollection)
          .doc(query.docs.first.id);
      await docRef.update({
        'sharedWith': FieldValue.arrayRemove([collaboratorId]),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      final reloaded = await docRef.get();
      final sharedWith = List<String>.from(
        reloaded.data()?['sharedWith'] ?? [],
      );
      if (sharedWith.isEmpty) {
        await docRef.update({'isShared': false});
      }
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw CFormatException();
    } catch (e) {
      throw 'Failed to remove collaborator from wishlist.';
    }
  }

  /// Update the sharing state for all wishlists owned by current user.
  Future<void> updateShareModeForOwner(bool shareMode) async {
    try {
      if (currentUser == null) throw Exception('User not logged in.');
      final query = await _db
          .collection(CKeys.wishlistCollection)
          .where('ownerId', isEqualTo: currentUser!.uid)
          .get();

      for (final doc in query.docs) {
        await _db.collection(CKeys.wishlistCollection).doc(doc.id).update({
          'isShared': shareMode,
          // Don't remove 'sharedWith' list when turning off
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw CFormatException();
    } catch (e) {
      throw 'Failed to update share mode.';
    }
  }
}

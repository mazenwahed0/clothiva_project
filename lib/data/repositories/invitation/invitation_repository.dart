import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/keys.dart';
import '../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../utils/exceptions/format_exceptions.dart';
import '../../../features/invitation/models/invitation_model.dart';
import '../../../features/personalization/models/user_model.dart';
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

      // 1. Get Sender's ID
      final senderId = _currentUser!.uid;

      // 2. Fetch Sender's User Record from Firestore
      final senderDoc = await _db
          .collection(CKeys.userCollection)
          .doc(senderId)
          .get();
      if (!senderDoc.exists) throw Exception("Sender user record not found.");

      // 3. Get Sender's Name from UserModel
      final senderUserModel = UserModel.fromSnapshot(senderDoc);
      final senderName = senderUserModel.fullName; // Use the fullName getter

      // 4. Fetch Recipient
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

      // 5. Create the Invite using the CORRECT senderName
      final invite = Invitation(
        id: '',
        senderId: senderId,
        senderName: senderName.isEmpty ? 'Unknown User' : senderName,
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

// lib/features/invitation/data/repositories/invitation_repo.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/../../data/repositories/user/user_repository.dart';
import '../models/invitation_model.dart';

class InvitationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference get _invitationsCollection =>
      _firestore.collection('invitations');

  User? get _currentUser => _auth.currentUser;

  /// ===== Send Invite with user check =====
  Future<void> sendInvite(String email) async {
    if (_currentUser == null) {
      throw Exception("User is not logged in.");
    }

    final cleanEmail = email.toLowerCase().trim();

    // Check if user exists
    final user = await UserRepository.instance.checkUserByEmail(cleanEmail);
    if (user == null) {
      throw Exception("No user found with this email.");
    }

    final newInvitation = Invitation(
      id: '',
      senderId: _currentUser!.uid,
      senderName: _currentUser!.displayName ?? 'Unknown User',
      recipientEmail: cleanEmail,
      status: InvitationStatus.pending,
      createdAt: DateTime.now(),
      shareEnabled: true,
    );

    await _invitationsCollection.add(newInvitation.toMap());
  }

  Stream<List<Invitation>> fetchPendingInvitations() {
    final userEmail = _currentUser?.email;
    if (userEmail == null) return Stream.value([]);

    return _invitationsCollection
        .where('recipientEmail', isEqualTo: userEmail.toLowerCase().trim())
        .where(
          'status',
          isEqualTo: InvitationStatus.pending.toString().split('.').last,
        )
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Invitation.fromFirestore(doc)).toList());
  }

  Stream<List<Invitation>> fetchCollaborators() {
    final currentUserId = _currentUser?.uid;
    if (currentUserId == null) return Stream.value([]);

    return _invitationsCollection
        .where('status', isEqualTo: InvitationStatus.accepted.toString().split('.').last)
        .where(
          Filter.or(
            Filter('senderId', isEqualTo: currentUserId),
            Filter('recipientId', isEqualTo: currentUserId),
          ),
        )
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Invitation.fromFirestore(doc)).toList());
  }

  Future<void> acceptInvite(String inviteId) async {
    if (_currentUser == null) throw Exception("User is not logged in.");

    await _invitationsCollection.doc(inviteId).update({
      'status': InvitationStatus.accepted.toString().split('.').last,
      'recipientId': _currentUser!.uid,
    });
  }

  Future<void> rejectInvite(String inviteId) async {
    await _invitationsCollection.doc(inviteId).update({
      'status': InvitationStatus.rejected.toString().split('.').last,
    });
  }

  Future<void> updateShareStatus(String inviteId, bool isEnabled) async {
    await _invitationsCollection.doc(inviteId).update({
      'shareEnabled': isEnabled,
    });
  }

  Stream<List<Invitation>> fetchSentInvitations() {
    final currentUserId = _currentUser?.uid;
    if (currentUserId == null) return Stream.value([]);

    return _invitationsCollection
        .where('senderId', isEqualTo: currentUserId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Invitation.fromFirestore(doc)).toList());
  }
}

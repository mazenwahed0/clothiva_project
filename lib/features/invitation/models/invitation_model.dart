import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/constants/enums.dart';

class Invitation {
  final String id;
  final String senderId;
  final String senderName;
  final String recipientEmail;
  final String? recipientId; // Nullable until accepted
  final String? recipientName;
  final InvitationStatus status;
  final DateTime createdAt;
  final bool shareEnabled;

  Invitation({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.recipientEmail,
    this.recipientId,
    this.recipientName,
    required this.status,
    required this.createdAt,
    required this.shareEnabled,
  });

  // Factory constructor to create Invitation from Firestore Document
  factory Invitation.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Invitation(
      id: doc.id,
      senderId: data['senderId'] as String,
      senderName: data['senderName'] as String,
      recipientEmail: data['recipientEmail'] as String,
      recipientId: data['recipientId'] as String?,
      recipientName: data['recipientName'] as String?,
      status: InvitationStatus.values.firstWhere(
        (e) => e.toString().split('.').last == data['status'],
        orElse: () => InvitationStatus.pending,
      ),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      shareEnabled: data['shareEnabled'] ?? true, // Default to true
    );
  }

  // Convert Invitation object to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'recipientEmail': recipientEmail,
      'recipientId': recipientId,
      'recipientName': recipientName,
      'status': status.toString().split('.').last, // e.g., 'pending'
      'createdAt': createdAt,
      'shareEnabled': shareEnabled,
    };
  }
}

// lib/features/invitation/data/models/invitation_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

enum InvitationStatus { pending, accepted, rejected }

class Invitation {
  final String id;
  final String senderId;
  final String senderName;
  final String recipientEmail;
  final String? recipientId; // Nullable until accepted
  final InvitationStatus status;
  final DateTime createdAt;
  final bool shareEnabled;

  Invitation({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.recipientEmail,
    this.recipientId,
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
      status: InvitationStatus.values.firstWhere(
        (e) => e.toString().split('.').last == data['status'],
        orElse: () => InvitationStatus.pending,
      ),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      shareEnabled: data['shareEnabled'] as bool? ?? true, // Default to true
    );
  }

  // Convert Invitation object to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'recipientEmail': recipientEmail,
      'recipientId': recipientId,
      'status': status.toString().split('.').last, // e.g., 'pending'
      'createdAt': createdAt,
      'shareEnabled': shareEnabled,
    };
  }

  // Helper method for updating the model immutably
  Invitation copyWith({
    String? id,
    String? senderId,
    String? senderName,
    String? recipientEmail,
    String? recipientId,
    InvitationStatus? status,
    DateTime? createdAt,
    bool? shareEnabled,
  }) {
    return Invitation(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      recipientEmail: recipientEmail ?? this.recipientEmail,
      recipientId: recipientId ?? this.recipientId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      shareEnabled: shareEnabled ?? this.shareEnabled,
    );
  }
}

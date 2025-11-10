import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/repositories/invitation/invitation_repository.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../shop/controllers/products/favourites_controller.dart';
import '../models/invitation_model.dart';

class InvitationController extends GetxController {
  static InvitationController get instance => Get.find();

  final userRepo = UserRepository.instance;
  final authRepo = AuthenticationRepository.instance;
  final invRepo = InvitationRepository.instance;
  final favCtrl = FavouritesController.instance;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  final RxList<Invitation> pendingInvitations = <Invitation>[].obs;
  final RxList<Invitation> collaborators = <Invitation>[].obs;
  final RxList<Invitation> sentInvitations = <Invitation>[].obs;

  /// Local-only toggle for recipient view mode.
  final RxBool isViewingShared = false.obs;

  String? get currentUserId => AuthenticationRepository.instance.authUser?.uid;

  bool get isOwner => collaborators.any((c) => c.senderId == currentUserId);

  bool get isRecipient =>
      collaborators.any((c) => c.recipientId == currentUserId) && !isOwner;

  @override
  void onInit() {
    super.onInit();

    // These streams are simple and fine
    invRepo.fetchPendingInvitations().listen(pendingInvitations.assignAll);
    invRepo.fetchSentInvitations().listen(sentInvitations.assignAll);

    // This single listener now handles updating the list AND setting the switch state.
    invRepo.fetchCollaborators().listen((collabs) {
      // Check if this is the very first time loading the list
      final isInitialLoad = collaborators.isEmpty && collabs.isNotEmpty;

      // 1. Update the list
      collaborators.assignAll(collabs);

      // 2. Handle switch/sharing logic
      _handleCollaborationUpdate(collabs, isInitialLoad: isInitialLoad);
    });
  }

  /// Handles logic for sharing status and recipient switch
  void _handleCollaborationUpdate(
    List<Invitation> collabs, {
    required bool isInitialLoad,
  }) {
    Invitation? myInvite;
    if (isRecipient) {
      myInvite = collabs.firstWhereOrNull(
        (c) => c.recipientId == currentUserId,
      );
    } else if (isOwner) {
      myInvite = collabs.firstWhereOrNull((c) => c.senderId == currentUserId);
    }

    // Logic for Recipient Switch
    if (isInitialLoad && myInvite != null) {
      // 1. On FIRST LOAD, set state from the database
      isViewingShared.value = myInvite.shareEnabled;
      favCtrl.isSharedMode.value = myInvite.shareEnabled;
    } else if (isRecipient && myInvite != null) {
      // 2. On SUBSEQUENT loads, check if the owner forced sharing off
      if (!myInvite.shareEnabled && isViewingShared.value) {
        // Owner disabled sharing, so force the switch off
        isViewingShared.value = false;
        favCtrl.isSharedMode.value = false;
        Loaders.warningSnackBar(
          title: "Sharing Disabled",
          message: "The owner has disabled shared access.",
        );
      }
    } else if (isOwner && myInvite != null) {
      // 3. Owner's view is always tied to the database state
      isViewingShared.value = myInvite.shareEnabled;
      favCtrl.isSharedMode.value = myInvite.shareEnabled;
    } else if (collabs.isEmpty) {
      // 4. No collaborations, reset to local
      isViewingShared.value = false;
      favCtrl.isSharedMode.value = false;
    }

    // favCtrl.refreshMode();
  }

  /// Recipient attempts to toggle their local view mode.
  void tryToggleLocalView(Invitation invite, bool value) {
    if (value == true) {
      // User wants to turn ON
      if (!invite.shareEnabled) {
        Loaders.warningSnackBar(
          title: "Sharing Disabled",
          message: "The owner has disabled shared access. You can't enable it.",
        );
        isViewingShared.value = false;
        favCtrl.isSharedMode.value = false;
      } else {
        isViewingShared.value = true;
        favCtrl.isSharedMode.value = true;

        Loaders.successSnackBar(
          title: 'Shared Wishlist is ON',
          message: 'You are now viewing the shared wishlist.',
        );
      }
    } else {
      // User wants to turn OFF
      isViewingShared.value = false;
      favCtrl.isSharedMode.value = false;

      Loaders.successSnackBar(
        title: 'Local Wishlist is ON',
        message: 'You are viewing your local wishlist.',
      );
    }
    favCtrl.refreshMode();
  }

  /// Send invite (only for owner)
  Future<void> sendInvite(String email) async {
    try {
      final connected = await NetworkManager.instance.isConnected();
      if (!connected) {
        Loaders.customToast(message: "No internet connection.");
        return;
      }

      if (!formKey.currentState!.validate() || email.isEmpty) {
        return;
      }

      final user = await userRepo.checkUserByEmail(email);
      if (user == null) {
        Loaders.errorSnackBar(
          title: "Not Found",
          message: "$email not found. Please try again.",
        );
        return;
      }

      if (user.email.toLowerCase() == authRepo.getUserEmail.toLowerCase()) {
        Loaders.errorSnackBar(
          title: "Oops!",
          message: "You can't send invites to yourself.",
        );
        return;
      }

      // --- Prevent duplicate invites ---
      final alreadySent = sentInvitations.any(
        (invite) =>
            invite.recipientEmail.toLowerCase() == email.toLowerCase() &&
            (invite.status == InvitationStatus.pending ||
                invite.status == InvitationStatus.accepted),
      );

      if (alreadySent) {
        Loaders.errorSnackBar(
          title: "Already sent",
          message: "You already sent an invitation to this user.",
        );
        return;
      }

      await invRepo.sendInvite(email);

      FullScreenLoader.stopLoading();
      Loaders.successSnackBar(
        title: "Success",
        message: "Invitation sent successfully.",
      );
    } catch (e) {
      Loaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }

  Future<void> acceptInvite(String inviteId) async {
    try {
      final connected = await NetworkManager.instance.isConnected();
      if (!connected) {
        Loaders.customToast(message: "No internet connection.");
        return;
      }

      await invRepo.acceptInvite(inviteId);
      // FavouritesController.instance.refreshMode();

      Loaders.successSnackBar(
        title: "Accepted",
        message: "Invitation accepted successfully.",
      );
    } catch (e) {
      Loaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }

  Future<void> rejectInvite(String inviteId) async {
    try {
      await invRepo.rejectInvite(inviteId);

      Loaders.warningSnackBar(
        title: "Rejected",
        message: "Invitation has been rejected.",
      );
    } catch (e) {
      Loaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }

  /// Owner toggles sharing ON/OFF globally in Firestore
  Future<void> toggleShareStatus(bool enabled) async {
    final invite = collaborators.firstWhereOrNull(
      (c) => c.senderId == currentUserId,
    );
    if (invite == null) {
      Loaders.errorSnackBar(
        title: "Error",
        message: "No collaboration found to update.",
      );
      return;
    }

    try {
      final connected = await NetworkManager.instance.isConnected();
      if (!connected) {
        Loaders.customToast(message: "No internet connection.");
        return;
      }

      await invRepo.updateShareStatus(invite.id, enabled);
      FavouritesController.instance.refreshMode();

      Loaders.successSnackBar(
        title: "Updated",
        message: enabled
            ? "Sharing enabled successfully."
            : "Sharing disabled successfully.",
      );
    } catch (e) {
      Loaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }

  /// Show confirmation dialog for leaving/removing
  void confirmRemoveOrLeave(Invitation invite) {
    final isOwner = invite.senderId == currentUserId;
    final title = isOwner ? "Remove Collaborator?" : "Leave Wishlist?";
    final message = isOwner
        ? "Are you sure you want to remove ${invite.recipientName ?? 'this user'}? This cannot be undone."
        : "Are you sure you want to leave ${invite.senderName}'s shared wishlist?";

    Get.defaultDialog(
      title: title,
      middleText: message,
      textConfirm: "Confirm",
      textCancel: "Cancel",
      onConfirm: () async {
        Get.back();
        await _removeOrLeave(invite);
      },
    );
  }

  /// Private helper to execute removal
  Future<void> _removeOrLeave(Invitation invite) async {
    try {
      final recipientId = invite.recipientId;
      if (recipientId == null) {
        throw Exception("Cannot remove: Recipient ID is missing.");
      }

      await invRepo.removeOrLeaveCollaboration(
        invite.id,
        invite.senderId,
        recipientId,
      );

      Loaders.successSnackBar(
        title: "Success",
        message: "Collaboration removed.",
      );
    } catch (e) {
      Loaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }
}

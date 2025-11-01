// lib/features/invitation/presentation/Invitation/invitation_controller.dart

import 'package:get/get.dart';
import 'package:clothiva_project/data/repositories/authentication/authentication_repository.dart';
import '../../data/models/invitation_model.dart';
import '../../data/repositories/invitation_repo.dart';

class InvitationController extends GetxController {
  final InvitationRepository _repository;

  InvitationController(this._repository);

  /// ======= Reactive State =======
  final RxList<Invitation> _pendingInvitations = <Invitation>[].obs;
  List<Invitation> get pendingInvitations => _pendingInvitations;

  final RxList<Invitation> _collaborators = <Invitation>[].obs;
  List<Invitation> get collaborators => _collaborators;

  final RxList<Invitation> _sentInvitations = <Invitation>[].obs;
  List<Invitation> get sentInvitations => _sentInvitations;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  String? get currentUserId => AuthenticationRepository.instance.authUser?.uid;

  /// ======= Lifecycle =======
  @override
  void onInit() {
    super.onInit();
    _listenToPendingInvitations();
    _listenToCollaborators();
    _listenToSentInvitations();
  }

  /// ======= Stream Listeners =======
  void _listenToPendingInvitations() {
    _repository.fetchPendingInvitations().listen((invites) {
      _pendingInvitations.assignAll(invites);
    });
  }

  void _listenToCollaborators() {
    _repository.fetchCollaborators().listen((collabs) {
      _collaborators.assignAll(collabs);
    });
  }

  void _listenToSentInvitations() {
    _repository.fetchSentInvitations().listen((sent) {
      _sentInvitations.assignAll(sent);
    });
  }

  /// ======= Core Functions =======

  /// Send Invite
  Future<void> sendInvite(String email) async {
    if (email.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a valid email.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    _isLoading.value = true;

    try {
      await _repository.sendInvite(email);
      Get.back(); // Close bottom sheet

      Get.snackbar(
        'Success',
        'Invitation sent successfully to $email.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send invitation: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  /// Accept Invite
  Future<void> acceptInvite(String inviteId) async {
    try {
      await _repository.acceptInvite(inviteId);
      Get.snackbar(
        'Accepted',
        'Invitation accepted successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to accept invitation: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Reject Invite
  Future<void> rejectInvite(String inviteId) async {
    try {
      await _repository.rejectInvite(inviteId);
      Get.snackbar(
        'Rejected',
        'Invitation rejected.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to reject invitation: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Toggle Sharing
  Future<void> toggleShareStatus(String inviteId, bool isEnabled) async {
    try {
      await _repository.updateShareStatus(inviteId, isEnabled);
      Get.snackbar(
        'Updated',
        'Sharing status updated.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update sharing status: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

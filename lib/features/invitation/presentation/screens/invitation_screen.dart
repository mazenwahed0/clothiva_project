// lib/features/invitation/presentation/screens/invitation_screen.dart

import 'package:clothiva_project/navigation_menu.dart';
import 'package:clothiva_project/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:clothiva_project/utils/constants/colors.dart';
import 'package:clothiva_project/common/widgets/appbar/appbar.dart';
import 'package:clothiva_project/common/widgets/loaders/animation_loader.dart';

import '../../data/models/invitation_model.dart';
import '../Invitation/invitation_controller.dart';

class InvitationScreen extends StatelessWidget {
  const InvitationScreen({super.key});

  InvitationController get controller => Get.find<InvitationController>();

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CAppBar(
        showActions: false,
        showSkipButton: false,
        showBackArrow: true,
        title: Text(
          'Invitations & Collaborators',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),

      body: Obx(() {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final hasData =
            controller.pendingInvitations.isNotEmpty ||
            controller.collaborators.isNotEmpty ||
            controller.sentInvitations.isNotEmpty;

        if (!hasData) {
          return CAnimationLoaderWidget(
            text: 'No invitations or collaborators found',
            animation: CImages.cartPage,
            showAction: false,
            actionText: 'Let\'s fill it',
            onActionPressed: () => Get.off(() => const NavigationMenu()),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// === Pending Invitations ===
              Text(
                'Pending Invitations to You',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: CSizes.spaceBtItems),

              controller.pendingInvitations.isEmpty
                  ? const Text('No pending invitations currently.')
                  : Column(
                      children: controller.pendingInvitations
                          .map(
                            (invite) => _buildPendingInviteTile(
                              context,
                              controller,
                              invite,
                              dark,
                            ),
                          )
                          .toList(),
                    ),

              const SizedBox(height: CSizes.spaceBtSections),
              const Divider(),
              const SizedBox(height: CSizes.spaceBtSections),

              /// === Active Collaborators ===
              Text(
                'Active Collaborators',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: CSizes.spaceBtItems),

              controller.collaborators.isEmpty
                  ? const Text('You have no active collaborators.')
                  : Column(
                      children: controller.collaborators
                          .where((c) => c.status == InvitationStatus.accepted)
                          .map(
                            (collaborator) => _buildCollaboratorTile(
                              context,
                              controller,
                              collaborator,
                            ),
                          )
                          .toList(),
                    ),

              const SizedBox(height: CSizes.spaceBtSections),
              const Divider(),
              const SizedBox(height: CSizes.spaceBtSections),

              /// === Sent Invitations ===
              Text(
                'Invitations You Sent',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: CSizes.spaceBtItems),

              controller.sentInvitations.isEmpty
                  ? const Text('No sent invitations.')
                  : Column(
                      children: controller.sentInvitations
                          .map(
                            (invite) => ListTile(
                              leading: const Icon(Icons.email_outlined),
                              title: Text(invite.recipientEmail),
                              subtitle: Text(
                                'Status: ${invite.status.name.toUpperCase()}',
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ],
          ),
        );
      }),

      /// === Bottom Button (Invite User) ===
      bottomNavigationBar: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: ElevatedButton(
            onPressed: controller.isLoading
                ? null
                : () => _showInviteBottomSheet(context, controller, dark),
            child: controller.isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Invite User'),
          ),
        );
      }),
    );
  }

  /// === Pending Invite Tile ===
  Widget _buildPendingInviteTile(
    BuildContext context,
    InvitationController controller,
    Invitation invite,
    bool dark,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: CSizes.spaceBtItems),
      child: Padding(
        padding: const EdgeInsets.all(CSizes.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Iconsax.notification_bing,
              color: dark ? CColors.warning : CColors.primary,
            ),
            const SizedBox(width: CSizes.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Invitation from: ${invite.senderName}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  const Text('Do you want to accept this invitation?'),
                  const SizedBox(height: CSizes.sm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () => controller.acceptInvite(invite.id),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: CSizes.sm,
                            vertical: CSizes.xs,
                          ),
                        ),
                        child: const Text('Accept'),
                      ),
                      const SizedBox(height: CSizes.xs),
                      OutlinedButton(
                        onPressed: () => controller.rejectInvite(invite.id),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: CSizes.sm,
                            vertical: CSizes.xs,
                          ),
                        ),
                        child: const Text('Reject'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// === Collaborator Tile ===
  Widget _buildCollaboratorTile(
    BuildContext context,
    InvitationController controller,
    Invitation collaborator,
  ) {
    final currentUserId = controller.currentUserId;
    final isSender = collaborator.senderId == currentUserId;
    final otherUser = isSender
        ? collaborator.recipientEmail
        : collaborator.senderName;

    return Card(
      margin: const EdgeInsets.only(bottom: CSizes.spaceBtItems),
      child: ListTile(
        leading: const Icon(Iconsax.user_tag),
        title: Text(otherUser),
        subtitle: const Text('Sharing Status'),
        trailing: Switch(
          value: collaborator.shareEnabled,
          onChanged: (bool value) {
            controller.toggleShareStatus(collaborator.id, value);
          },
        ),
      ),
    );
  }

  /// === Invite Bottom Sheet ===
  void _showInviteBottomSheet(
    BuildContext context,
    InvitationController controller,
    bool dark,
  ) {
    final emailController = TextEditingController();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: dark ? Colors.grey[900] : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        ),
        height: Get.height * 0.35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Text(
              'Invite New User',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Enter Email Address",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.isLoading
                        ? null
                        : () async {
                            final email = emailController.text.trim();
                            if (email.isEmpty) {
                              Get.snackbar(
                                'Error',
                                'Please enter an email',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              return;
                            }
                            await controller.sendInvite(email);
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: controller.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Send Invite'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/widgets/appbar/appbar.dart';
import '../../../common/widgets/loaders/animation_loader.dart';
import '../../../navigation_menu.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/validators/validation.dart';
import '../controllers/invitation_controller.dart';
import '../models/invitation_model.dart';
import 'widgets/collaborator_tile.dart';
import 'widgets/pending_invite_tile.dart';

class InvitationScreen extends StatelessWidget {
  const InvitationScreen({super.key});

  InvitationController get controller => Get.find<InvitationController>();

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CAppBar(
        showActions: true,
        showSkipButton: false,
        showBackArrow: true,
        title: Text(
          'Invitations',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          // Global Switch for Owner
          Obx(() {
            if (!controller.isOwner) {
              return const SizedBox.shrink();
            }
            final isEnabled = controller.collaborators.isNotEmpty
                ? controller.collaborators.first.shareEnabled
                : false;
            return Row(
              children: [
                Text(isEnabled ? "Sharing ON" : "Sharing OFF"),
                Switch(
                  value: isEnabled,
                  onChanged: (value) => controller.toggleShareStatus(value),
                ),
              ],
            );
          }),
        ],
      ),
      body: Obx(() {
        final hasData =
            controller.pendingInvitations.isNotEmpty ||
            controller.collaborators.isNotEmpty ||
            controller.sentInvitations.isNotEmpty;

        if (!hasData) {
          return CAnimationLoaderWidget(
            text: 'No invitations or collaborators found.',
            animation: CImages.invitationPage,
            showAction: false,
            onActionPressed: () => Get.off(() => const NavigationMenu()),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// === Pending Invitations ===
              if (controller.collaborators.isEmpty) ...[
                Text(
                  'Pending Invitations to You',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: CSizes.spaceBtItems),
                Obx(
                  () => controller.pendingInvitations.isEmpty
                      ? const Text('No pending invitations currently.')
                      : Column(
                          children: controller.pendingInvitations
                              .map(
                                (invite) => PendingInviteTile(
                                  context: context,
                                  invite: invite,
                                ),
                              )
                              .toList(),
                        ),
                ),
                const SizedBox(height: CSizes.spaceBtSections),
                const Divider(),
                const SizedBox(height: CSizes.spaceBtSections),
              ],

              /// === Active Collaborators ===
              Text(
                'Active Collaborators',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: CSizes.spaceBtItems),
              Obx(
                () => controller.collaborators.isEmpty
                    ? const Text('You have no active collaborators.')
                    : Column(
                        children: controller.collaborators
                            .where((c) => c.status == InvitationStatus.accepted)
                            .map(
                              (collaborator) => CollaboratorTile(
                                context: context,
                                collaborator: collaborator,
                              ),
                            )
                            .toList(),
                      ),
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
              Obx(
                () => controller.sentInvitations.isEmpty
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
              ),
            ],
          ),
        );
      }),

      /// === Bottom Button (Invite User) ===
      bottomNavigationBar: Obx(() {
        if (controller.isRecipient) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: ElevatedButton(
            // --- FIX: Removed isLoading check ---
            onPressed: () => _showInviteBottomSheet(context, controller, dark),
            child: const Text('Invite User'),
          ),
        );
      }),
    );
  }

  /// === Invite Bottom Sheet ===
  void _showInviteBottomSheet(
    BuildContext context,
    InvitationController controller,
    bool dark,
  ) {
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
            Form(
              key: controller.formKey,
              child: TextFormField(
                controller: controller.emailController,
                validator: (value) => CValidator.validateEmail(value),
                decoration: InputDecoration(
                  labelText: 'Enter Email Address',
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
                    onPressed: () async {
                      if (!controller.formKey.currentState!.validate()) return;
                      // Controller handles loader and closing the sheet
                      await controller.sendInvite(
                        controller.emailController.text.trim(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    // --- FIX: Removed spinner ---
                    child: const Text('Send Invite'),
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

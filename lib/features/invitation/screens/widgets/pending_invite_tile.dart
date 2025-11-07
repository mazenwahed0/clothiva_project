import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/invitation_controller.dart';
import '../../models/invitation_model.dart';

class PendingInviteTile extends StatelessWidget {
  const PendingInviteTile({
    super.key,
    required this.context,
    required this.invite,
  });

  final BuildContext context;
  final Invitation invite;

  InvitationController get controller => Get.find<InvitationController>();

  @override
  Widget build(BuildContext context) {
    bool dark = context.isDarkMode;

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
}

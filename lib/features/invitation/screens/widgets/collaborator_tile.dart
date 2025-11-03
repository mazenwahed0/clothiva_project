import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/invitation_controller.dart';
import '../../models/invitation_model.dart';

class CollaboratorTile extends StatelessWidget {
  const CollaboratorTile({
    super.key,
    required this.context,
    required this.collaborator,
  });

  final BuildContext context;
  final Invitation collaborator;

  InvitationController get controller => Get.find<InvitationController>();

  @override
  Widget build(BuildContext context) {
    final currentUserId = controller.currentUserId;
    final isSender = collaborator.senderId == currentUserId;
    final isRecipient = collaborator.recipientId == currentUserId;

    final otherUser = isSender
        ? (collaborator.recipientName ?? collaborator.recipientEmail)
        : collaborator.senderName;

    return Card(
      margin: const EdgeInsets.only(bottom: CSizes.spaceBtItems),
      child: ListTile(
        leading: const Icon(Iconsax.user_tag),
        title: Text(otherUser),
        subtitle: Text(isSender ? "Collaborator" : "Owner"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. Recipient's Local View Toggle
            if (isRecipient)
              Obx(() => Switch(
                    value: controller.isViewingShared.value,
                    onChanged: (bool value) =>
                        controller.tryToggleLocalView(collaborator, value),
                  )),

            // 2. Leave / Remove Button
            IconButton(
              icon: Icon(
                isSender ? Iconsax.trash : Iconsax.logout,
                color: CColors.error,
              ),
              onPressed: () => controller.confirmRemoveOrLeave(collaborator),
            )
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import '../../../../utils/constants/sizes.dart';
// import '../../controllers/invitation_controller.dart';
// import '../../models/invitation_model.dart';

// class CollaboratorTile extends StatelessWidget {
//   const CollaboratorTile({
//     super.key,
//     required this.context,
//     required this.collaborator,
//   });

//   final BuildContext context;
//   final Invitation collaborator;

//   InvitationController get controller => Get.find<InvitationController>();

//   @override
//   Widget build(BuildContext context) {
//     final currentUserId = controller.currentUserId;
//     final isSender = collaborator.senderId == currentUserId;
//     final isRecipient = collaborator.recipientId == currentUserId;

//     final otherUser = isSender
//         ? (collaborator.recipientName ?? collaborator.recipientEmail)
//         : collaborator.senderName;

//     return Card(
//       margin: const EdgeInsets.only(bottom: CSizes.spaceBtItems),
//       child: ListTile(
//         leading: const Icon(Iconsax.user_tag),
//         title: Text(otherUser),
//         subtitle: const Text('Sharing Status'),

//         /// 👇 Use different Switches for owner and recipient
//         trailing: isSender
//             ? Switch(
//                 value: collaborator.shareEnabled,
//                 onChanged: (bool value) =>
//                     controller.toggleShareStatus(collaborator.id, value),
//               )
//             : Obx(() => Switch(
//                   value: controller.isViewingShared.value,
//                   onChanged: (bool value) =>
//                       controller.tryToggleLocalView(collaborator, value),
//                 )),
//       ),
//     );
//   }
// }

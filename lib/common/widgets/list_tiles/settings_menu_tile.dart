import 'package:clothiva_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class SettingsMenuTile extends StatelessWidget {
  const SettingsMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title, subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 28, color: CColors.primary),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium!),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.labelLarge!),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

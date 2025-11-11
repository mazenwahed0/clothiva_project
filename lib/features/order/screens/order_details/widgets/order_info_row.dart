import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrderInfoRow extends StatelessWidget {
  const OrderInfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.valueColor,
    this.isTotal = false,
  });

  final IconData icon;
  final String title;
  final String value;
  final Color? valueColor;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey),
            const SizedBox(width: CSizes.spaceBtItems / 2),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        Text(
          value,
          style: isTotal
              ? Theme.of(context).textTheme.titleLarge
              : Theme.of(context).textTheme.bodyLarge?.apply(color: valueColor),
        ),
      ],
    );
  }
}

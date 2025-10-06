import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';

class TitleWithIcon extends StatelessWidget {
  const TitleWithIcon(
      {super.key,
      this.textColor = CColors.white,
      this.maxLines = 1,
      required this.title,
      required this.icon,
      this.iconColor = CColors.white,
      this.textAlign = TextAlign.center,
      this.textSize = TextSizes.medium});

  final String title;
  final IconData icon;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes textSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: iconColor, size: CSizes.iconMd),
        const SizedBox(width: CSizes.xs),
        Flexible(
          child: Text(
            title,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            // Check which TextSize is required and set that style.
            style: textSize == TextSizes.small
                ? Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor)
                : textSize == TextSizes.medium
                    ? Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(color: textColor)
                    : textSize == TextSizes.large
                        ? Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .apply(color: textColor)
                        : Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(color: textColor),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart'; // Changed to TColors

/// A circular container widget with optional child, border, and styling.
class TCircularContainer extends StatelessWidget {
  /// Create a circular container.
  ///
  /// Parameters:
  ///   - child: The optional child widget to be placed inside the container.
  ///   - margin: The margin around the container.
  ///   - padding: The padding inside the container.
  ///   - width: The width of the container.
  ///   - height: The height of the container.
  ///   - radius: The radius of the circular border.
  ///   - backgroundColor: The background color of the container.
  const TCircularContainer({
    super.key,
    this.child,
    this.padding = EdgeInsets.zero, // Defaulted to EdgeInsets.zero to represent '0'
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.margin,
    this.backgroundColor = CColors.white, // Changed to TColors
  });

  final double? width;
  final double? height;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding, // Using the constructor's padding
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: backgroundColor,
        ),
        child: child,
        );
    }
}
import 'package:flutter/material.dart';

/// A circular container widget with optional child, border, and styling.
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
    super.key,
    this.child,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
  });

  final double? width;
  final double radius;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}

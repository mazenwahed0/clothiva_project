import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';
import '../curved_edges/curved_edges_widget.dart';
import 'circular_container.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgesWidget(
      child: Container(
        color: CColors.dashboardAppbarBackground,
        padding: const EdgeInsets.only(bottom: 0),
        child: Stack(
          children: [
            /// -- Background Custom Shapes
            Positioned(
              top: -150,
              right: -250,
              child: TCircularContainer(
                backgroundColor: CColors.textWhite.withValues(alpha: 0.1),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: TCircularContainer(
                backgroundColor: CColors.textWhite.withValues(alpha: 0.1),
              ),
            ),

            /// -- لازم يتلف عشان يبان فوق الـ shapes
            Align(
              alignment: Alignment.topCenter,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}


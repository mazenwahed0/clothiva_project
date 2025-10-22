import 'package:clothiva_project/common/widgets/icons/circular_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularIcon(icon: Iconsax.heart5,color: Colors.red,);
  }
}

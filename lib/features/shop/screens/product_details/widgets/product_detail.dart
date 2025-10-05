import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';


class ProductDetail extends StatelessWidget{
  const ProductDetail({super.key});
  @override
  Widget build(BuildContext context) {
    final isDark = CHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CurvedEdgesWidget(
              child: Container(
                color: isDark ? CColors.darkGrey : CColors.white,  //no color named light
                child: Stack(
                  children: [
                    SizedBox(
                        height : 400,
                        child: Padding(
                          padding: const EdgeInsets.all(CSizes.productImageRadius * 2),
                          child: Center(
                              child: Image(image: AssetImage(CImages.productImage1))),
                        )
                    ),
                  ],
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
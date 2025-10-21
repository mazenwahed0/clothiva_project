import 'package:clothiva_project/common/widgets/appbar/appbar.dart';
import 'package:clothiva_project/common/widgets/brands/brand_card.dart';
import 'package:clothiva_project/common/widgets/layouts/grid_layout.dart';
import 'package:clothiva_project/common/widgets/texts/section_heading.dart';
import 'package:clothiva_project/features/shop/screens/brand/brand_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/sizes.dart';

class AllBrandScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(showActions: false, showSkipButton: true),
      body: SingleChildScrollView(
        child:
        Padding(
          padding: EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              SectionHeading(title: 'Brands',showActionButton: false,),
              SizedBox(height: CSizes.spaceBtSections,),
              GridLayout(
                  itemCount: 10,
                  mainAxisExtent: 80,
                  itemBuilder: (context,index)=>CBrandCard(showBorder: true,onTap: ()=>Get.to(()=> BrandProducts()),),
              )
            ],
        ),
        ),
      ),
    );
  }
  
}
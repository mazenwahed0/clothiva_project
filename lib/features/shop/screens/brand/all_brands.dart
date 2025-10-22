import 'package:clothiva_project/common/widgets/appbar/appbar.dart';
import 'package:clothiva_project/common/widgets/brands/brand_card.dart';
import 'package:clothiva_project/common/widgets/layouts/grid_layout.dart';
import 'package:clothiva_project/common/widgets/texts/section_heading.dart';
import 'package:clothiva_project/features/shop/controllers/brand_controller.dart';
import 'package:clothiva_project/features/shop/models/brand_model.dart';
import 'package:clothiva_project/features/shop/screens/brand/brand_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common/widgets/shimmers/brands_shimmer.dart';
import '../../../../utils/constants/sizes.dart';

class AllBrandScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final brandController =BrandController.instance;
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
              Obx((){
                if(brandController.isLoading.value)return CBrandsShimmer();

                if(brandController.allBrands.isEmpty){
                  return Center(child: Text("No Data Found",style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),),);
                }
                return GridLayout(
                  itemCount: brandController.allBrands.length,
                  mainAxisExtent: 80,
                  itemBuilder: (_, index) {
                    final brand=brandController.allBrands[index];
                    // -- Passing Each Brand & onPress Event from Backend
                    return CBrandCard(
                      showBorder: true,
                      brand: brand,
                      onTap: ()=>Get.to(()=>BrandProducts(brand: brand,)),
                    );
                  },
                );
              }
              )
            ],
        ),
        ),
      ),
    );
  }
  
}
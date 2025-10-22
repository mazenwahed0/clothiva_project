import 'package:clothiva_project/common/widgets/appbar/appbar.dart';
import 'package:clothiva_project/common/widgets/brands/brand_card.dart';
import 'package:clothiva_project/common/widgets/products/sortable/sortableproducts.dart';
import 'package:clothiva_project/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:clothiva_project/features/shop/controllers/brand_controller.dart';
import 'package:clothiva_project/features/shop/models/brand_model.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:clothiva_project/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key,  required this.brand});
  final BrandModel brand;
  @override
  Widget build(BuildContext context) {
    final controller=BrandController.instance;
    return Scaffold(
      appBar: CAppBar(showActions: false, showSkipButton: true,title: Text(brand!.name,style: TextStyle(color: Colors.black),),),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(CSizes.defaultSpace),
        child:Column(
          children: [
            CBrandCard(showBorder: true,brand: brand!,),
            SizedBox(height: CSizes.spaceBtSections,),

            FutureBuilder(future: controller.getBrandProducts(brand!.id), builder: (context,snapshot){
              const loader=CVerticalProductShimmer();
              final widget=TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
              if(widget!=null)return widget;

              final brandProducts=snapshot.data!;
              return SortableProducts(products: brandProducts);
            })

          ],
        ),
        ),
      ),
    );
  }
}

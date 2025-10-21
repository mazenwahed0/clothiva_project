import 'package:clothiva_project/common/widgets/appbar/appbar.dart';
import 'package:clothiva_project/common/widgets/layouts/grid_layout.dart';
import 'package:clothiva_project/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:clothiva_project/common/widgets/products/sortable/sortableproducts.dart';
import 'package:clothiva_project/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/all_products_controller.dart';
import '../../models/product_model.dart';

class AllProducts extends StatelessWidget{
  const AllProducts({super.key, required this.title, this.query, this.futureMethod});
  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(AllProductController());
    return Scaffold(
      appBar: CAppBar(showActions: false, showSkipButton: true,title: Text(title),),
      body: SingleChildScrollView(
        child:
        Padding(padding: EdgeInsets.all(CSizes.defaultSpace),
          child:
          FutureBuilder(
              future: futureMethod??controller.fetchProductByQuery(query),
              builder: (context,snapshot) {
                const loader=CVerticalProductShimmer();
                //
                // if(snapshot.connectionState==ConnectionState.waiting){
                //   return loader;
                // }
                // if(!snapshot.hasData||snapshot.data==null||snapshot.data!.isEmpty){
                //   return Center(child: Text("No Data Found!"),);
                // }
                final widget=TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
                if(widget!=null)return widget;

                final products=snapshot.data!;
                return SortableProducts(products: products,);
          }
          ),
        )
      )
    );
  }
  
}
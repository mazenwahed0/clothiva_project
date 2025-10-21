import 'package:clothiva_project/common/widgets/appbar/appbar.dart';
import 'package:clothiva_project/common/widgets/layouts/grid_layout.dart';
import 'package:clothiva_project/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:clothiva_project/common/widgets/products/sortable/sortableproducts.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

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
            Column(
              children: [
                DropdownButtonFormField(
                  onChanged: (value){},
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.sort),
                  ),
                  items: ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest', 'Popularity']
                    .map((option) => DropdownMenuItem(value: option,child: Text(option)))
                    .toList(),
                ),
                const SizedBox(height: CSizes.spaceBtItems,),
                /// Products
                GridLayout(itemCount: 4, itemBuilder: (_,index)=>  ProductCardVertical(product: ))
              ],
            ),
          // FutureBuilder(future: futureMethod??controller.fetchProductByQuery(query), builder: (context,snapshot){
          //   return SortableProducts();
          ),
        )
      );

  }
  
}
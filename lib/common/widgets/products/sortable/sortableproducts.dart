import 'package:clothiva_project/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:clothiva_project/features/shop/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/all_products_controller.dart';
import '../../layouts/grid_layout.dart';
import '../../../../utils/constants/sizes.dart';

class SortableProducts extends StatelessWidget{
  const SortableProducts({super.key, required this.products});
  final List<ProductModel>products;
  @override
  Widget build(BuildContext context) {
    final controller=Get.put(AllProductController());
    controller.assignProducts(products);
    return Column(
      children: [
        DropdownButtonFormField(
            decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
            items: ['Name','Higher Price','Lower Price','Sale','Newest','Oldest']
            .map((option)=>DropdownMenuItem(value: option,child: Text(option),)).toList(),
            value: controller.selectedSortOption.value,
            onChanged: (value){
              controller.sortProducts(value!);
            }
        ),
        const SizedBox( height: CSizes.spaceBtItems,),
        Obx(()=>GridLayout(itemCount: controller.products.length, itemBuilder: (_,index)=>ProductCardVertical(product: controller.products[index])))
      ],
    );
  }

}
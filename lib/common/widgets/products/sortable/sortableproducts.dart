import 'package:clothiva_project/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:clothiva_project/features/shop/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../layouts/grid_layout.dart';
import '../../../../utils/constants/sizes.dart';

class SortableProducts extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField(items: ['Name','Higher Price','Lower Price','Sale','Newest','Oldest']
            .map((option)=>DropdownMenuItem(value: option,child: Text(option),)).toList(),
            onChanged: (value){}
        ),
        const SizedBox( height: CSizes.spaceBtItems,),
        GridLayout(itemCount: 8, itemBuilder: (_,index)=>ProductCardVertical(product: ProductModel.empty()))
      ],
    );
  }

}
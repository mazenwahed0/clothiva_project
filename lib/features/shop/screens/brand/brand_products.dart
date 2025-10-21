import 'package:clothiva_project/common/widgets/appbar/appbar.dart';
import 'package:clothiva_project/common/widgets/brands/brand_card.dart';
import 'package:clothiva_project/common/widgets/products/sortable/sortableproducts.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(showActions: false, showSkipButton: true,title: Text('Nike',style: TextStyle(color: Colors.black),),),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(CSizes.defaultSpace),
        child:Column(
          children: [
            CBrandCard(showBorder: true),
            SizedBox(height: CSizes.spaceBtSections,),
            SortableProducts(products: [])
          ],
        ),
        ),
      ),
    );
  }
}

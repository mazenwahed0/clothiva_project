import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/sortable/sortableproducts.dart';
import '../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/products/all_products_controller.dart';
import '../../models/product_model.dart';

class AllProducts extends StatelessWidget {
  const AllProducts(
      {super.key, required this.title, this.query, this.futureMethod});
  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    return Scaffold(
        appBar: CAppBar(
          showActions: false,
          showSkipButton: false,
          showBackArrow: true,
          title: Text(title),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(CSizes.defaultSpace),
          child: FutureBuilder(
              future: futureMethod ?? controller.fetchProductByQuery(query),
              builder: (context, snapshot) {
                const loader = CVerticalProductShimmer();
                final widget = CloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot, loader: loader);
                if (widget != null) return widget;

                final products = snapshot.data!;
                return SortableProducts(products: products);
              }),
        )));
  }
}

import 'package:clothiva_project/data/repositories/product/product_repository.dart';
import 'package:clothiva_project/features/shop/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../utils/popups/loaders.dart';

class AllProductController extends GetxController{
  static AllProductController get instance=>Get.find();

  //Variables
  final repository=ProductRepository.instance;

  Future<List<ProductModel>>  fetchProductByQuery(Query? query)async{
    try{
      if(query==null)return[];

      final products=await repository.fetchProductsByQuery(query);
      return products;
    }
    catch(e){
      Loaders.errorSnackBar(title: 'oh Snap!', message: e.toString());
      return[];
    }

  }
}
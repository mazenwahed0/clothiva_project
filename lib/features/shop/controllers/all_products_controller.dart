import 'package:clothiva_project/data/repositories/product/product_repository.dart';
import 'package:clothiva_project/features/shop/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../utils/popups/loaders.dart';

class AllProductController extends GetxController{
  static AllProductController get instance=>Get.find();

  //Variables
  final repository=ProductRepository.instance;
  final RxString selectedSortOption='Name'.obs;
  final RxList<ProductModel> products=<ProductModel>[].obs;

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

  void sortProducts(String sortoption){
    selectedSortOption.value=sortoption;
    switch(sortoption){
      case 'Name':
        products.sort((a,b)=>a.title.compareTo(b.title));
        break;
      case 'Higher Price':
        products.sort((a,b)=>b.price.compareTo(a.price));
        break;
      case 'Lower Price':
        products.sort((a,b)=>a.price.compareTo(b.price));
        break;
      case'Newest':
        products.sort((a,b)=>a.date!.compareTo(b.date!));
        break;
      case 'Sale':
        products.sort((a,b){
          if(b.salePrice>0){
            return b.salePrice.compareTo(a.salePrice);
          }
          else if(a.salePrice>0){
            return -1;
          }
          else{
            return 1;
          }
        });
    }
  }

  void assignProducts(List<ProductModel>products){
    this.products.assignAll(products);
    sortProducts('Name');
  }
}
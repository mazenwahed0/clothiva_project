import 'dart:convert';

import 'package:clothiva_project/data/repositories/product/product_repository.dart';
import 'package:clothiva_project/features/shop/models/product_model.dart';
import 'package:clothiva_project/utils/local_storage/storage_utility.dart';
import 'package:clothiva_project/utils/popups/exports.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FavouritesController extends GetxController{
  static FavouritesController get instance=> Get.find();

  final favourites=<String,bool>{}.obs;

  void onInit(){
    super.onInit();
    initFavourites();
  }

  void initFavourites(){
    final json=CLocalStorage.instance().readData('favourites');
    if(json!=null){
      final storedFavourites=jsonDecode(json)as Map<String,dynamic>;
      favourites.assignAll(storedFavourites.map((key,value)=>MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String productId){
    return favourites[productId]??false;
  }

  void toggleFavouriteProduct(String productId){
    if(!favourites.containsKey(productId)){
      favourites[productId]=true;
      saveFavouritesToStorage();
      Loaders.customToast(message: 'Product has been added to wishlist.');
    }
    else{
      CLocalStorage.instance().readData(productId);
      favourites.remove(productId);
      saveFavouritesToStorage();
      favourites.refresh();
      Loaders.customToast(message: 'Product has been removed from wishlist.');
    }
  }

  void saveFavouritesToStorage() {
    final encodeFavourites=json.encode(favourites);
    CLocalStorage.instance().writeData('favourites', encodeFavourites);
  }

  Future<List<ProductModel>> favouriteProducts() async{
    return await ProductRepository.instance.getFavouriteProducts(favourites.keys.toList());
  }
}
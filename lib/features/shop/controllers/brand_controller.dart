import 'package:clothiva_project/data/repositories/brand/brand_repository.dart';
import 'package:clothiva_project/data/repositories/product/product_repository.dart';
import 'package:clothiva_project/features/shop/models/brand_model.dart';
import 'package:clothiva_project/utils/popups/exports.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/product_model.dart';

class BrandController extends GetxController{
  static BrandController get instance =>Get.find();

  RxBool isLoading =true.obs;
  final RxList<BrandModel> featuredBrands=<BrandModel>[].obs;
  final RxList<BrandModel> allBrands=<BrandModel>[].obs;
  final brandRepository=Get.put(BrandRepository());

  void onInit(){
    getFeaturedBrands();
    super.onInit();
  }

  //load brands
  Future<void> getFeaturedBrands()async{
    try{
      isLoading.value=true;
      final brands=await brandRepository.getAllBrands();
      allBrands.assignAll(brands);

      featuredBrands.assignAll(allBrands.where((brand)=>brand.isFeatured??false).take(4));
    }catch(e){
      Loaders.errorSnackBar(title: 'oh Snap!',message: e.toString());
    }finally{
      isLoading.value=false;
    }
  }

  //Get brands for category

  //get brand for specific product from your data source
  Future<List<ProductModel>>getBrandProducts(String brandId)async{
    try{
      final products=await ProductRepository.instance.getProductsForBrand(brandId: brandId);
      return products;
    }catch(e){
      Loaders.errorSnackBar(title: 'oh Snap!',message: e.toString());
      return [];
    }
  }
}
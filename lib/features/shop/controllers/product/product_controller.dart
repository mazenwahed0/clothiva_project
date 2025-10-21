import 'package:clothiva_project/data/repositories/product/product_repository.dart';
import 'package:clothiva_project/features/shop/models/product_model.dart';
import 'package:clothiva_project/utils/constants/enums.dart';
import 'package:get/get.dart';

import '../../../../utils/popups/loaders.dart';
class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  /// Variables
  final isLoading = false.obs;
  final productRepository=Get.put(ProductRepository());
  // List of Products to fetch and keep the data to avoid many reads from the Firestore Database
  final RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  void fetchFeaturedProducts() async {
    try {
      //show loader while fetching data
      isLoading.value=true;
      //fetch products
      final products=await productRepository.getFeaturedProducts();
      //Assign products
      featuredProducts.assignAll(products);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value=false;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      //fetch products
      final products=await productRepository.getFeaturedProducts();
      return products;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
      return[];
    }
  }


  String getProductPrice(ProductModel product){
    double smallestPrice=double.infinity;
    double largestPrice=0;
    //if no variations exist return price or sale
    if(product.productType==ProductType.single.toString()){
      return (product.salePrice>0?product.salePrice:product.price).toString();
    }
    else{
      //Calculate the smallest and largest prices among variations
      for(var variation in product.productVariations!){
        double priceToConsider=variation.salePrice>0? variation.salePrice:variation.price;
        if(priceToConsider<smallestPrice){
          smallestPrice=priceToConsider;
        }
        if(priceToConsider>largestPrice){
          largestPrice=priceToConsider;
        }
      }
      if(smallestPrice.isEqual(largestPrice)){
        return largestPrice.toString();
      }
      else {
        return '$smallestPrice-$largestPrice';
      }
    }

  }

  String? CalculateSalePercentage(double originalprice,double? salePrice){
    if(salePrice==null||salePrice<=0.0)return null;
    if(originalprice<=0.0)return null;
    double percentage =((originalprice-salePrice)/originalprice)*100;
    return percentage.toStringAsFixed(0);
  }

  String getProductStockStatus(int stock){
    return stock>0?'In Stock':'Out of Stock';
  }
}

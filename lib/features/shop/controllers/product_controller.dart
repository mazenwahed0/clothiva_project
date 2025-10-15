import 'package:clothiva_project/data/repositories/product/product_repository.dart';
import 'package:clothiva_project/features/shop/models/product_model.dart';
import 'package:get/get.dart';

import '../../../utils/popups/loaders.dart';
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
}

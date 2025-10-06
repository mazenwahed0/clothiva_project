import 'package:clothiva_project/features/shop/models/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  /// Variables
  final isLoading = false.obs;
  // List of Products to fetch and keep the data to avoid many reads from the Firestore Database
  final RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  void fetchFeaturedProducts() async {
    try {
      isLoading.value;
    } catch (e) {
    } finally {}
  }
}

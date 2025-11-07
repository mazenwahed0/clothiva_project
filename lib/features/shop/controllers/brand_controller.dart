import 'package:clothiva_project/data/repositories/brands/brand_repository.dart';
import 'package:clothiva_project/data/repositories/product/product_repository.dart';
import 'package:clothiva_project/features/shop/models/brand_model.dart';
import 'package:clothiva_project/features/shop/models/product_model.dart';
import 'package:get/get.dart';

import '../../../utils/popups/loaders.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  /// Variables
  final isLoading = false.obs;
  final brandRepository = Get.put(BrandRepository());
  RxList<BrandModel> allBrands = <BrandModel>[].obs;
  RxList<BrandModel> featuredBrands = <BrandModel>[].obs;

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  /// -- Load Brands
  void getFeaturedBrands() async {
    try {
      // Show Loader while loading Brands
      isLoading.value = true;

      final brands = await brandRepository.fetchBrands();

      allBrands.assignAll(brands);

      featuredBrands.assignAll(
        allBrands.where((brand) => brand.isFeatured ?? false).take(4),
      );
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oops!', message: e.toString());
    } finally {
      // Remove Loader
      isLoading.value = false;
    }
  }

  /// -- Get Brands for Category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      final brands = await brandRepository.fetchBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oops!', message: e.toString());
      return [];
    }
  }

  /// Get Brand Specific Products from your data source
  Future<List<ProductModel>> getBrandProducts({
    required String brandId,
    int limit = -1,
  }) async {
    try {
      final products = await ProductRepository.instance.getProductsForBrand(
        brandId: brandId,
        limit: limit,
      );
      return products;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oops!', message: e.toString());
      return [];
    }
  }
}

import 'package:clothiva_project/data/repositories/categories/category_repository.dart';
import 'package:clothiva_project/data/repositories/product/product_repository.dart';
import 'package:clothiva_project/features/shop/models/category_model.dart';
import 'package:clothiva_project/features/shop/models/product_model.dart';
import 'package:get/get.dart';

import '../../../utils/constants/text_strings.dart';
import '../../../utils/popups/loaders.dart';

// Only fetch the Categories one time when application loads to (Reduce Firebase Reads)
class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  /// Variables
  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  /// -- Load category data & featured categories from Firebase
  Future<void> fetchCategories() async {
    try {
      // Start Loading while loading categories
      isLoading.value = true;

      // Fetch categories from data source (Firestore, API, etc.)
      final categories = await _categoryRepository.getAllCategories();

      // Update the categories list
      allCategories.assignAll(categories);

      // Filter featured categories
      featuredCategories.assignAll(
        allCategories
            .where(
              (category) => category.isFeatured && category.parentId.isEmpty,
            )
            .take(4)
            .toList(),
      );
    } catch (e) {
      Loaders.errorSnackBar(title: CTexts.ohSnap, message: e.toString());
    } finally {
      // Remove Loader
      isLoading.value = false;
    }
  }

  /// -- Load selected category data
  Future<List<CategoryModel>> getSubCategory(String categoryId) async {
    try {
      final subCategories = await _categoryRepository.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      Loaders.errorSnackBar(title: CTexts.ohSnap, message: e.toString());
      return [];
    }

  }
  /// Get Category or Sub-Category Products.
  Future<List<ProductModel>> getCategoryProducts({required String categoryId, int limit = 4}) async {
    try{
    final products = await ProductRepository.instance.getProductsForCategory(categoryId: categoryId, limit: limit);
    return products;
    }catch(e){
      Loaders.errorSnackBar(title: CTexts.ohSnap, message: e.toString());
      return [];
    }
  }
}

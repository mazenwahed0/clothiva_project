import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/product_model.dart';
import 'product_controller.dart';

class AllProductController extends GetxController {
  static AllProductController get instance => Get.find();

  //Variables
  final repository = ProductRepository.instance;
  final productController = ProductController.instance;
  final RxString selectedSortOption = 'Name'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

  Future<List<ProductModel>> fetchProductByQuery(Query? query) async {
    try {
      if (query == null) return [];

      final products = await repository.fetchProductsByQuery(query);
      return products;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oops!', message: e.toString());
      return [];
    }
  }

  void sortProducts(String sortoption) {
    selectedSortOption.value = sortoption;
    switch (sortoption) {
      case 'Name':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Higher Price':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Lower Price':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Newest':
        products.sort((a, b) {
          if (a.date == null && b.date == null) return 0;
          if (a.date == null) return 1;
          if (b.date == null) return -1;
          return b.date!.compareTo(a.date!);
        });
        break;
      case 'Oldest':
        products.sort((a, b) {
          if (a.date == null && b.date == null) return 0;
          if (a.date == null) return 1;
          if (b.date == null) return -1;
          return a.date!.compareTo(b.date!);
        });
        break;
      case 'Sale':
        products.sort((a, b) {
          final percentA =
              double.tryParse(
                productController.CalculateSalePercentage(
                      a.price,
                      a.salePrice,
                    ) ??
                    '0',
              ) ??
              0;
          final percentB =
              double.tryParse(
                productController.CalculateSalePercentage(
                      b.price,
                      b.salePrice,
                    ) ??
                    '0',
              ) ??
              0;

          return percentB.compareTo(percentA);
        });
        break;
      default:
        products.sort((a, b) => a.title.compareTo(b.title));
    }
  }

  void assignProducts(List<ProductModel> products) {
    this.products.assignAll(products);
    sortProducts('Name');
  }
}

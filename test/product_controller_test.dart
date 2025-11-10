import 'package:flutter_test/flutter_test.dart';
import 'package:clothiva_project/features/shop/controllers/products/product_controller.dart';
import 'package:clothiva_project/data/repositories/product/product_repository.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

// Make the mock a GetxService
class MockProductRepository extends GetxService
    with Mock
    implements ProductRepository {}

void main() {
  late ProductController controller;

  setUp(() {
    Get.reset();

    // Use Get.put() to register the mock service *before* the controller needs it
    Get.put<ProductRepository>(MockProductRepository());

    // Now when this line runs, ProductRepository.instance will find the mock
    controller = ProductController();
  });

  group('ProductController Logic Tests', () {
    test('CalculateSalePercentage calculates correctly', () {
      expect(controller.CalculateSalePercentage(100, 80), '20');
    });

    test('CalculateSalePercentage returns null for no sale', () {
      expect(controller.CalculateSalePercentage(100, 0), null);
      expect(controller.CalculateSalePercentage(100, null), null);
    });

    test('getProductStockStatus returns correct status', () {
      expect(controller.getProductStockStatus(5), 'In Stock');
      expect(controller.getProductStockStatus(0), 'Out of Stock');
      expect(controller.getProductStockStatus(-1), 'Out of Stock');
    });
  });
}

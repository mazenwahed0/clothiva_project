import 'package:flutter_test/flutter_test.dart';
import 'package:clothiva_project/utils/helpers/pricing_functions.dart';

void main() {
  // Group tests related to CPricingCalculator
  group('CPricingCalculator Tests', () {
    // Test Case 1: Test the calculateTotalPrice function
    test('calculateTotalPrice calculates correct total', () {
      // 1. Arrange
      const double productPrice = 100.0;
      const String location = 'US';
      // From your file: tax is 0.10 (10%) and shipping is 5.00
      // 100.0 + (100.0 * 0.10) + 5.00 = 115.00
      const double expectedTotalPrice = 115.0;

      // 2. Act
      final double actualTotalPrice = CPricingCalculator.calculateTotalPrice(
        productPrice,
        location,
      );

      // 3. Assert
      expect(actualTotalPrice, expectedTotalPrice);
    });

    // Test Case 2: Test the calculateTax function
    test('calculateTax calculates correct tax amount', () {
      // 1. Arrange
      const double productPrice = 200.0;
      const String location = 'US';
      // From your file: tax rate is 0.10 (10%)
      // 200.0 * 0.10 = 20.0. The function returns a string.
      const String expectedTax = '20.00';

      // 2. Act
      final String actualTax = CPricingCalculator.calculateTax(
        productPrice,
        location,
      );

      // 3. Assert
      expect(actualTax, expectedTax);
    });

    // Test Case 3: Test the calculateShippingCost function
    test('calculateShippingCost returns correct shipping cost', () {
      // 1. Arrange
      const double productPrice = 100.0;
      const String location = 'US';
      // From your file: shipping cost is 5.00
      const String expectedShippingCost = '5.00';

      // 2. Act
      final String actualShippingCost =
          CPricingCalculator.calculateShippingCost(productPrice, location);

      // 3. Assert
      expect(actualShippingCost, expectedShippingCost);
    });
  });
}

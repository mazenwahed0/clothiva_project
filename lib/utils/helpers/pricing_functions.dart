class CPricingCalculator {
  // Calculate price based on tax and shipping
  static double calculateTotalPrice(double productPrice, String location) {
    double taxRate =
        getTaxRateForLocation(location); // Get tax rate based on location
    double taxAmount = productPrice * taxRate; // Calculate the tax amount
    double shippingCost =
        getShippingCost(location); // Get the shipping cost based on location

    double totalPrice =
        productPrice + taxAmount + shippingCost; // Calculate total price
    return totalPrice;
  }

  // Calculate shipping cost
  static String calculateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(location); // Get shipping cost
    return shippingCost
        .toStringAsFixed(2); // Return shipping cost with 2 decimal places
  }

  // Calculate tax
  static String calculateTax(double productPrice, String location) {
    double taxRate =
        getTaxRateForLocation(location); // Get tax rate based on location
    double taxAmount = productPrice * taxRate; // Calculate the tax amount
    return taxAmount
        .toStringAsFixed(2); // Return tax amount with 2 decimal places
  }

  // Get tax rate based on location
  static double getTaxRateForLocation(String location) {
    // You can lookup the tax rate for the given location from a tax rate database or API.
    // For now, returning a fixed rate for illustration purposes.
    return 0.10; // Example tax rate of 10%
  }

  // Get shipping cost based on location
  static double getShippingCost(String location) {
    // You can lookup the shipping cost for the given location from a shipping rate database or API.
    // For now, returning a fixed value for illustration purposes.
    return 5.00; // Example shipping cost of $5
  }

  // Sum all cart values and return total amount
  // static double calculateCartTotal(CartModel cart) {
  //   return cart.items.map((e) => e.price).fold(0, (previousPrice, currentPrice) => previousPrice + (currentPrice ?? 0));
  // }
}

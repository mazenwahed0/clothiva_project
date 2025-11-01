import 'package:clothiva_project/features/shop/controllers/products/image_controller.dart';
import 'package:get/get.dart';

import '../../models/product_model.dart';
import '../../models/product_variation_model.dart';
import '../../../cart/controllers/cart_controller.dart';

class VariationController extends GetxController {
  // final cartController = CartController.instance;
  // CartController get cartController => Get.find<CartController>();
  CartController get cartController => CartController.instance; ////////////
  static VariationController get instance => Get.find();

  //Variables
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;
  final products = <ProductModel>[].obs;
  RxInt cartQuantity = 0.obs;
  RxString selectedProductImage = ''.obs;

  @override
  void onInit() {
    resetSelectedAttributes();
    super.onInit();
  }

  /// -- Select Attribute, and Variation
  void onAttributeSelected(
    ProductModel product,
    attributeName,
    attributeValue,
  ) {
    // When attribute is selected we will first add that attribute to the selectedAttributes.
    final selectedAttributes = Map<String, dynamic>.from(
      this.selectedAttributes,
    );
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    // Select Product Variation using all the selected Attributes including new one just added.
    // We will simply loop through all product variations and find the match of same Attributes
    // e.g. : Selected Attributes [Color: Green, Size: Small]
    // e.g. : Product Variation [Color: Green, Size: Small] -> Will be selected.
    final ProductVariationModel selectedVariation = product.productVariations!
        .firstWhere(
          (variation) => _isSameAttributeValues(
            variation.attributeValues,
            selectedAttributes,
          ),
          orElse: () => ProductVariationModel.empty(),
        );

    // Show the selected Variation image as a Main Image
    if (selectedVariation.image.isNotEmpty) {
      ImageController.instance.selectedProductImage.value =
          selectedVariation.image;
    }

    // Show selected variation quantity already in the cart.
    if (selectedVariation.id.isNotEmpty) {
      cartQuantity.value = CartController.instance
          .calculateSingleProductCartEntries(product.id, selectedVariation.id);
    }

    this.selectedVariation.value = selectedVariation;

    // Update selected product variation status
    getProductVariationStockStatus();
  }

  /// -- Check If selected attributes matches any variation attributes
  bool _isSameAttributeValues(
    Map<String, dynamic> variationAttributes,
    Map<String, dynamic> selectedAttributes,
  ) {
    // If selectedAttributes contains 3 attributes and current variation contains 2 then return.
    if (variationAttributes.length != selectedAttributes.length) return false;

    // If any of the attributes is different then return. e.g. [Green, Large] x [Green, Small]
    for (final key in variationAttributes.keys) {
      // Attributes[Key] = Value which could be [Green, Small, Cotton] etc.
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }

    return true;
  }

  /// -- Check Attribute availability / Stock in Variation
  Set<String?> getAttributesAvailabilityInVariation(
    List<ProductVariationModel> variations,
    String attributeName,
  ) {
    // Pass the variations to check which attributes are available and stock is not 0
    final availableVariationAttributeValues = variations
        .where(
          (variation) =>
              // Check Empty / Out of Stock Attributes
              variation.attributeValues[attributeName] != null &&
              variation.attributeValues[attributeName]!.isNotEmpty,
        )
        // && variation.stock > 0
        // Fetch all non-empty attributes of variations
        .map((variation) => variation.attributeValues[attributeName])
        .toSet();

    return availableVariationAttributeValues;
  }

  /// -- Add selected variation to cart
  void addProductToCart(ProductModel product) {
    // Product do not have any variations, Simply add to cart
    if (product.productVariations == null) {
      CartController.instance.addMultipleItemsToCart(
        product,
        ProductVariationModel.empty(),
        cartQuantity.value,
      );
      Get.back();
    } else {
      final variation = selectedVariation.value;
      if (variation.id.isEmpty) {
        Get.snackbar(
          'Select Variation',
          'To add items in the cart you first have to select a Variation of this product.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      } else {
        CartController.instance.addMultipleItemsToCart(
          product,
          variation,
          cartQuantity.value,
        );
        Get.back();
      }
    }
  }

  void getProductVariationStockStatus() {
    variationStockStatus.value = selectedVariation.value.stock > 0
        ? 'In Stock'
        : 'Out of Stock';
  }

  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }

  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0
            ? selectedVariation.value.salePrice
            : selectedVariation.value.price)
        .toString();
  }
}

// import 'package:get/get.dart';

// import '../../models/product_model.dart';
// import '../../models/product_variation_model.dart';
// import 'cart_controller.dart';
// import 'image_controller.dart';

// class VariationController extends GetxController {
//   // final cartController = CartController.instance;
//   // CartController get cartController => Get.find<CartController>();
//   CartController get cartController => CartController.instance; ////////////
//   static VariationController get instance => Get.find();

//   //Variables
//   RxMap selectedAttributes = {}.obs;
//   RxString variationStockStatus = ''.obs;
//   Rx<ProductVariationModel> selectedVariation =
//       ProductVariationModel.empty().obs;

//   void onAttributesAvailabilityInVariation(
//       ProductModel product, attributeName, attributeValue) {
//     final selectedAttributes =
//         Map<String, dynamic>.from(this.selectedAttributes);
//     selectedAttributes[attributeName] = attributeValue;

//     final selectedVariation = product.productVariations!.firstWhere(
//         (variation) => _isSameAttributeValues(
//             variation.attributeValues, selectedAttributes),
//         orElse: () => ProductVariationModel.empty());

//     //Show selected variation
//     if (selectedVariation.image.isNotEmpty) {
//       ImageController.instance.selectedProductImage.value =
//           selectedVariation.image;
//     }

//     if (selectedVariation.id.isNotEmpty) {
//       cartController.productQuantityInCart.value = cartController
//           .getVariationProductQuantityInCart(product.id, selectedVariation.id);
//     }

//     this.selectedVariation.value = selectedVariation;

//     getProductVariationStockStatus();
//   }

//   bool _isSameAttributeValues(Map<String, dynamic> variationAttributes,
//       Map<String, dynamic> selectedAttributes) {
//     if (variationAttributes.length != selectedAttributes.length) {
//       return false;
//     }

//     for (final key in variationAttributes.keys) {
//       if (variationAttributes[key] != selectedAttributes[key]) {
//         return false;
//       }
//     }
//     return true;
//   }

//   Set<String?> getAttributesAvailabilityInVariation(
//       List<ProductVariationModel> variations, String attributeName) {
//     //Pass variations to check which attributes are available and stock is not 0
//     final availableVariationAttributeValues = variations
//         .where((variation) =>
//             variation.attributeValues[attributeName] != null &&
//             variation.attributeValues[attributeName]!.isNotEmpty &&
//             variation.stock > 0)
//         .map((variation) => variation.attributeValues[attributeName])
//         .toSet();
//     return availableVariationAttributeValues;
//   }

//   void getProductVariationStockStatus() {
//     variationStockStatus.value =
//         selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
//   }

//   void resetSelectedAttributes() {
//     selectedAttributes.clear();
//     variationStockStatus.value = '';
//     selectedVariation.value = ProductVariationModel.empty();
//   }

//   String getVariationPrice() {
//     return (selectedVariation.value.salePrice > 0
//             ? selectedVariation.value.salePrice
//             : selectedVariation.value.price)
//         .toString();
//   }
// }

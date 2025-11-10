import 'package:get/get.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/local_storage/storage_utility.dart';
import '../../../utils/popups/loaders.dart';
import '../models/cart_item_model.dart';
import '../../shop/models/product_model.dart';
import '../../shop/models/product_variation_model.dart';
import '../../shop/controllers/products/variation_controller.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  // Variables
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;

  CartController() {
    loadCartItems();
    totalCartPrice.value = cartItems
        .map((e) => calculateSingleProductTotal(e.price!, e.quantity))
        .fold(0, (previous, current) => previous + current);
    // Assuming cartItems are already populated
    // cartItems.map((element) => productQuantities.addAll({element.productId: element.quantity})).toList();
  }

  double calculateSingleProductTotal(double productPrice, int quantity) {
    return productPrice * quantity;
  }

  // Add items in the cart
  void addToCart(ProductModel product) {
    // Quantity Check
    if (productQuantityInCart.value < 1) {
      Loaders.customToast(message: 'Select Quantity');
      return;
    }

    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      Loaders.customToast(message: 'Select Variation');
      return;
    }

    // Out of Stock Status
    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        Loaders.warningSnackBar(
          title: 'Oops!',
          message: 'Selected variation is out of stock',
        );
        return;
      }
    } else {
      if (product.stock < 1) {
        Loaders.warningSnackBar(
          title: 'Oops!',
          message: 'Selected Product is out of stock',
        );
        return;
      }
    }

    // Convert the ProductModel to a CartItemModel with the given quantity
    final selectedCartItem = convertToCartItem(
      product,
      productQuantityInCart.value,
    );

    // Check if already added in the Cart
    int index = cartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == selectedCartItem.productId &&
          cartItem.variationId == selectedCartItem.variationId,
    );

    if (index >= 0) {
      // This quantity is already added or Updated/Removed from the design (Cart)(-)
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();
    Loaders.customToast(message: 'Your Product has been added to the cart.');
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == item.productId &&
          cartItem.variationId == item.variationId,
    );

    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }

    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == item.productId &&
          cartItem.variationId == item.variationId,
    );

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems[index].quantity == 1
            ? removeFromCartDialog(item)
            : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void removeFromCartDialog(CartItemModel cartItem) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this product?',
      onConfirm: () {
        // Remove the item from the cart
        cartItems.remove(cartItem);
        // Remove that product from the Product Quantities.
        // productQuantities.remove(cartItem.productId);
        // Remove the price from the total
        totalCartPrice.value -= calculateSingleProductTotal(
          cartItem.price!,
          cartItem.quantity,
        );
        cartItems.refresh();
        updateCart();

        Get.back();
        Loaders.customToast(message: 'Product removed from the cart.');
      },
      onCancel: () =>
          () => Get.back(),
      barrierDismissible: true,
    );
  }

  // Intialize already added Item's count in the cart.
  void updateAlreadyAddedProductCount(ProductModel product) {
    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      final variationId = variationController.selectedVariation.value.id;
      if (variationId.isNotEmpty) {
        productQuantityInCart.value = getVariationProductQuantityInCart(
          product.id,
          variationId,
        );
      } else {
        productQuantityInCart.value = 0;
      }
    }
  }

  // This function converts a ProductModel to CartItemModel
  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      // Reset variation in case of single product type.
      variationController.resetSelectedAttributes();
    }

    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
        ? variation.salePrice > 0.0
              ? variation.salePrice
              : variation.price
        : product.salePrice > 0.0
        ? product.salePrice
        : product.price;

    return CartItemModel(
      productId: product.id,
      title: product.title,
      price: price,
      quantity: quantity,
      variationId: variation.id,
      image: isVariation ? variation.image : product.thumbnail,
      brandName: product.brand != null ? product.brand!.name : '',
      selectedVariation: isVariation ? variation.attributeValues : null,
    );
  }

  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;

    for (var item in cartItems) {
      calculatedTotalPrice += (item.price) * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;
    }

    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  void saveCartItems() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    CLocalStorage.instance().saveData('cartItems', cartItemStrings);
  }

  void loadCartItems() {
    final cartItemStrings = CLocalStorage.instance().readData<List<dynamic>>(
      'cartItems',
    );

    if (cartItemStrings != null) {
      cartItems.assignAll(
        cartItemStrings.map(
          (item) => CartItemModel.fromJson(item as Map<String, dynamic>),
        ),
      );
      updateCartTotals();
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  int getVariationProductQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
      (item) => item.productId == productId && item.variationId == variationId,
      orElse: () => CartItemModel.empty(),
    );

    return foundItem.quantity;
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }

  int calculateSingleProductCartEntries(String productId, String variationId) {
    int cartEntries = 0;

    // If variation is not null get variation total
    if (variationId.isEmpty) {
      cartEntries = cartItems
          .where((item) => item.productId == productId)
          .map((e) => e.quantity)
          .fold(
            0,
            (previousQuantity, nextQuantity) => previousQuantity + nextQuantity,
          );
    } else {
      cartEntries = cartItems
          .where(
            (item) =>
                item.productId == productId && item.variationId == variationId,
          )
          .map((e) => e.quantity)
          .fold(
            0,
            (previousQuantity, nextQuantity) => previousQuantity + nextQuantity,
          );
    }

    return cartEntries;
  }

  void addMultipleItemsToCart(
    ProductModel product,
    ProductVariationModel variation,
    int quantity,
  ) {
    // If the product is already added then increment the count else add new product
    final cartItem = cartItems.firstWhere(
      (item) =>
          item.productId == product.id && item.variationId == variation.id,
      orElse: () => CartItemModel(
        productId: product.id,
        variationId: variation.id,
        quantity: 0,
        title: product.title,
        image: variation.id.isEmpty ? product.thumbnail : variation.image,
        price: variation.id.isEmpty
            ? product.salePrice ?? product.price
            : variation.salePrice ?? variation.price,
        brandName: product.brand!.name,
        selectedVariation: variation.id.isNotEmpty
            ? variation.attributeValues
            : null,
      ),
    );

    // If its a new product Simply add quantity
    if (cartItem.quantity == 0) {
      // Increment Cart
      cartItem.quantity = quantity;
      cartItems.add(cartItem);
      // Increment Total Cart Price
      totalCartPrice.value += calculateSingleProductTotal(
        product.price,
        quantity,
      );
      // Increment Product Quantities
      // productQuantities[product.id] = quantity;
    } else {
      // Check if you need to remove or add items to the cart
      if (cartItem.quantity > quantity) {
        // Subtract
        totalCartPrice.value -= calculateSingleProductTotal(
          cartItem.price!,
          quantity,
        );
        // Set the new quantity of productQuantities
        // if (productQuantities.containsKey(product.id)) {
        //   productQuantities[product.id] = (productQuantities[product.id] ?? 0) - quantity;
        // }
      } else {
        // Increment
        totalCartPrice.value += calculateSingleProductTotal(
          product.price,
          quantity,
        );
        // if (productQuantities.containsKey(product.id)) {
        //   productQuantities[product.id] = (productQuantities[product.id] ?? 0) + quantity;
        // }
      }

      cartItem.quantity = quantity;
    }

    // Must use .refresh() when list or Modal is Observable to change UI
    cartItems.refresh();
  }
}

// import 'package:clothiva_project/features/cart/models/cart_item_model.dart';
// import 'package:clothiva_project/features/shop/models/product_model.dart';
// import 'package:clothiva_project/utils/local_storage/storage_utility.dart';
// import 'package:clothiva_project/utils/popups/exports.dart';
// import 'package:get/get.dart';

// class CartController extends GetxController {
//   static CartController get instance => Get.find();


//   // Variables
//   RxInt noOfCartItems = 0.obs;
//   RxDouble totalCartPrice = 0.0.obs;
//   RxInt productQuantityInCart = 0.obs;
//   RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
//   final variationController = VariationController.instance;

//   // Add items in the cart
//   void addToCart(ProductModel product) {
//     // Quantity Check
//     if(productQuantityInCart.value < 1) {
//       Loaders.customToast(message: 'Select Quantity');
//       return;
//     }

//     if(product.productType == ProductType.variable.toString() &&
//         variationController.selectedVariation.value.isEmpty) {
//       Loaders.customToast(message: 'Select Variation');
//       return;
//     }

//     // Out of Stock Status
//     if (product.productType == ProductType.variable.toString()) {
//       if (variationController.selectedVariation.value.stock < 1) {
//         Loaders.warningSnackBar(title: 'Oh Snap!', message: 'Selected variation is out of stock');
//         return;
//       }
//     } else {
//       if (product.stock < 1) {
//         Loaders.warningSnackBar(title: 'Oh Snap!', message: 'Selected Product is out of stock');
//         return;
//       }
//     }

//     // Convert the ProductModel to a CartItemModel with the given quantity
//     final selectedCartItem = convertToCartItem(product, productQuantityInCart.value);

//     // Check if already added in the Cart
//     int index = cartItems
//     .indexWhere((cartItem) => cartItem.productId == selectedCartItem.productId && cartItem.variationId == selectedCartItem.variationId);

//     if(index >= 0){
//       // This quantity is already added or Updated/Removed from the design (Cart)(-)
//       cartItems[index].quantity = selectedCartItem.quantity;
//     } else {
//       cartItems.add(selectedCartItem);
//     }

//     updateCart();
//     Loaders.customToast(message: 'Your Product has been added to the cart.');
//   }

//     // This function converts a ProductModel to CartItemModel
//     CartItemModel convertToCartItem(ProductModel product, int quantity) {
      
//       if(product.productType == ProductType.single.toString()) {
//         // Reset variation in case of single product type.
//         variationController.resetSelectedAttributes();
//     }

//     final variation = variationController.selectedVariation.value;
//     final isVariation = variation.id.isNotEmpty;
//     final price = isVariation
//      ? variation.salePrice > 0.0
//        ? variation.salePrice
//        : variation.price
//     : product.salePrice > 0.0
//        ? product.salePrice
//        : product.price;


//    return CartItemModel(
//     productId: product.id,
//     title: product.title,
//     price: price,
//     quantity: quantity,
//     variationId: variation.id,
//     image: isVariation ? variation.image : product.thumbnail,
//     brandName: product.brand != null ? product.brand!.name : '',
//     selectedVariation: isVariation ? variation.attributeValues : null,
//     );
//   }

//   void updateCart() {
//     updateCartTotals();
//     saveCartItems();
//     cartItems.refresh();
//   }

//   void updateCartTotals() {
//     double calculatedTotalPrice = 0.0;
//     int calculatedNoOfItems = 0;

//     for(var item in cartItems) {
//       calculatedTotalPrice += (item.price) * item.quantity.toDouble();
//       calculatedNoOfItems += item.quantity;
//     }

//     totalCartPrice.value = calculatedTotalPrice;
//     noOfCartItems.value = calculatedNoOfItems;
//   }

//   void saveCartItems() {
//     final cartItemStrings = cartItems.map(item) => item.toJson(()).toList();
//     CLocalStorage.instance().writeData('cartItems', cartItemStrings);
//   }
// }
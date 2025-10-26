class CartItemModel {
  int quantity;
  String productId;
  String variationId;
  double price;
  String? image;
  String title;
  String? brandName;
  Map<String, String>? selectedVariation;

  CartItemModel({
    required this.quantity,
    required this.productId,
    this.variationId = '',
    this.image,
    this.price = 0.0,
    this.title = '',
    this.brandName,
    this.selectedVariation,
  });

  // Empty Cart
  static CartItemModel empty() => CartItemModel(productId: '', variationId: '', quantity: 0);


  // Convert a CartItem to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'productId' : productId,
      'title' : title,
      'price' : price,
      'image' : image,
      'quantity' : quantity,
      'variationId' : variationId,
      'brandName' : brandName,
      'selectedVariation' : selectedVariation,
    };
  }

  // Create a CartItem from a JSON Map
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'],
      title: json['title'],
      price: json['price']?.toDouble(),
      image: json['image'],
      quantity: json['quantity'],
      variationId: json['variationId'],
      brandName: json['brandName'],
      selectedVariation: json['selectedVariation'] != null
          ? Map<String, String>.from(json['selectedVariation'])
          : null,
    );
  }
}

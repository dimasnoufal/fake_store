import 'package:fake_store/app/data/models/product_item.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        product: Product.fromJson(json['product']),
        quantity: json['quantity'],
      );

  Map<String, dynamic> toJson() => {
        'product': product.toJson(),
        'quantity': quantity,
      };
}

class Cart {
  final Product product;
  final int numOfItem;

  Cart({required this.product, required this.numOfItem});
}

List<Cart> demoCarts = [
  Cart(product: sampleProduct, numOfItem: 2),
  Cart(product: sampleProduct, numOfItem: 1),
  Cart(product: sampleProduct, numOfItem: 1),
  Cart(product: sampleProduct, numOfItem: 1),
  Cart(product: sampleProduct, numOfItem: 1),
  Cart(product: sampleProduct, numOfItem: 1),
];

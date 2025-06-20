import 'package:fake_store/app/data/models/product_item.dart';

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

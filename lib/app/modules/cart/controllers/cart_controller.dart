import 'package:fake_store/app/data/models/cart_item.dart';
import 'package:fake_store/app/data/models/product_item.dart';
import 'package:fake_store/app/services/cart_service.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  //Initialze variables
  RxDouble totalPrice = 0.0.obs;

  // Initialize methods
  final cart = Get.find<CartService>();

  @override
  void onInit() {
    super.onInit();
    total();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void incrementQty(Product product, int qty) =>
      cart.add(product, quantity: qty);
  void decrementQty(Product product, int qty) =>
      cart.removeOne(product, quantity: qty);

  void total() {
    demoCarts.forEach((cart) {
      totalPrice.value += cart.product.price * cart.numOfItem;
    });
  }
}

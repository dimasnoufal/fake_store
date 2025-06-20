import 'package:fake_store/app/data/models/cart_item.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  //Initialze variables
  RxDouble totalPrice = 0.0.obs;

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

  void total() {
    demoCarts.forEach((cart) {
      totalPrice.value += cart.product.price * cart.numOfItem;
    });
  }
}

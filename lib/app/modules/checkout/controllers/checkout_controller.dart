import 'package:fake_store/app/data/models/cart_item.dart';
import 'package:fake_store/app/helper/shared/logger.dart';
import 'package:fake_store/app/services/cart_service.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  // Initializing variables
  final paymentName = 'Transfer Bank';
  final args = Get.arguments as List<CartItem>;
  get subtotal => args.fold<double>(
        0,
        (sum, item) => sum + (item.product.price * item.quantity),
      );
  final discount = 0.0;
  final shipping = 0.0;
  get total => subtotal + shipping - discount;

  // Initializing methods
  final cart = Get.find<CartService>();

  @override
  void onInit() {
    super.onInit();
    printArgs();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void printArgs() {
    Logger.printInfo('Arguments: ${args.map((e) => e.toJson()).toList()}');
  }
}

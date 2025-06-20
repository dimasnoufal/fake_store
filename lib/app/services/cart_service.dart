import 'dart:convert';
import 'package:fake_store/app/data/models/cart_item.dart';
import 'package:fake_store/app/data/models/product_item.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService extends GetxService {
  static const _key = 'cart_items';
  late SharedPreferences _prefs;

  final RxList<CartItem> items = <CartItem>[].obs;

  Future<CartService> init() async {
    _prefs = await SharedPreferences.getInstance();
    final raw = _prefs.getString(_key);
    if (raw != null) {
      final list =
          (jsonDecode(raw) as List).map((e) => CartItem.fromJson(e)).toList();
      items.assignAll(list);
    }
    return this;
  }

  void add(Product p, {int quantity = 1}) {
    final index = items.indexWhere((c) => c.product.id == p.id);
    if (index == -1) {
      items.add(CartItem(product: p, quantity: quantity));
    } else {
      items[index].quantity += quantity;
      items.refresh();
    }
    _persist();
  }

  void removeOne(Product p, {int quantity = 1}) {
    final index = items.indexWhere((c) => c.product.id == p.id);
    if (index == -1) return;
    if (items[index].quantity > quantity) {
      items[index].quantity -= quantity;
      items.refresh();
    } else {
      items.removeAt(index);
    }
    _persist();
  }

  void clear() {
    items.clear();
    _persist();
  }

  double get total =>
      items.fold(0, (sum, e) => sum + e.product.price * e.quantity);

  void _persist() =>
      _prefs.setString(_key, jsonEncode(items.map((e) => e.toJson()).toList()));
}

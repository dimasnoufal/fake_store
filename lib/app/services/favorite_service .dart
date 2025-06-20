import 'dart:convert';
import 'package:fake_store/app/data/models/product_item.dart';
import 'package:fake_store/app/helper/shared/logger.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService extends GetxService {
  static const _prefsKey = 'favorite_products';
  late SharedPreferences _prefs;

  final RxMap<int, Product> favorites = <int, Product>{}.obs;

  Future<FavoriteService> init() async {
    _prefs = await SharedPreferences.getInstance();

    final String? jsonStr = _prefs.getString(_prefsKey);
    if (jsonStr != null) {
      final decoded = jsonDecode(jsonStr) as List;
      Logger.printInfo('Decoded favorites: $decoded');
      for (final item in decoded) {
        final p = Product.fromJson(item);
        favorites[p.id] = p..isFavourite = true;
      }
    }
    return this;
  }

  bool isFavorite(int id) => favorites.containsKey(id);

  void toggle(Product p) {
    if (isFavorite(p.id)) {
      favorites.remove(p.id);
    } else {
      favorites[p.id] = p..isFavourite = true;
    }
    _persist();
  }

  void _persist() {
    final listJson =
        favorites.values.map((p) => p.toJson()).toList(growable: false);
    _prefs.setString(_prefsKey, jsonEncode(listJson));
  }
}

import 'package:fake_store/app/data/api.dart';
import 'package:fake_store/app/data/models/product_item.dart';
import 'package:fake_store/app/helper/shared/enum.dart';
import 'package:fake_store/app/helper/shared/logger.dart';
import 'package:fake_store/app/helper/shared/string.dart';
import 'package:fake_store/app/helper/widgets/dialogs.dart';
import 'package:fake_store/app/services/cart_service.dart';
import 'package:fake_store/app/services/check_connectivity.dart';
import 'package:fake_store/app/services/favorite_service%20.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailItemController extends GetxController {
  // Initializing variables
  RxInt selectedImage = 0.obs;
  RxInt selectedColor = 0.obs;
  RxInt countItem = 1.obs;
  RxBool isShowMore = false.obs;
  final id = int.parse(Get.parameters['id']!);
  final requestStatus = requestState.isEmpty.obs;
  late ProductItem dataGetProduct;
  late Product product;
  late RxBool isFav;
  List<dynamic> image = <dynamic>[].obs;
  AppLocalizations get strings => AppLocalizations.of(Get.context!)!;
  RxBool showSeeMore = false.obs;

  // Initializing method
  final fav = Get.find<FavoriteService>();
  final cart = Get.find<CartService>();

  @override
  void onInit() {
    super.onInit();
    checkId();
    isFav = RxBool(fav.isFavorite(id));
    getProduct();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void checkId() {
    Logger.printInfo('Id $id');
  }

  void toggleFavorite() {
    fav.toggle(product);
    isFav.value = fav.isFavorite(id);
  }

  void addItem() => countItem.value++;

  void removeItem() {
    if (countItem.value > 1) {
      countItem.value--;
    }
  }

  Future<void> getProduct() async {
    requestStatus.value = requestState.isLoading;
    final Api api = Api(storeBaseUrl);

    try {
      bool isConnected = await CheckConnectivity.isConnected();

      final responseGetProduct = await api.get('/products/${id.toString()}');

      Logger.printInfo('Response Get Product: ${responseGetProduct}');

      if (isConnected) {
        if (responseGetProduct['statusCode'] == 200) {
          // dataGetProduct
          //     .assignAll(Map<String, dynamic>.from(responseGetProduct['body']));
          // image = [dataGetProduct['image']];

          dataGetProduct = ProductItem.fromJson(
              Map<String, dynamic>.from(responseGetProduct['body']));
          showSeeMore.value = dataGetProduct.description.length > 150;
          image = [dataGetProduct.image];
          Logger.printInfo('Data Get Product: ${dataGetProduct}');

          product = Product(
            id: dataGetProduct.id,
            title: dataGetProduct.title,
            description: dataGetProduct.description,
            images: [image[0]],
            colors: [Colors.red, Colors.blue, Colors.green],
            rating: dataGetProduct.rating.rate,
            price: dataGetProduct.price,
            isFavourite: isFav.value,
          );
          Logger.printInfo('Product: ${product.toJson()}');

          requestStatus.value = requestState.isSuccess;
        } else {
          requestStatus.value = requestState.isError;
          Logger.printX(
              'Get product failed with status code: ${responseGetProduct['statusCode']}');
        }
      } else {
        Future.delayed(Duration(seconds: 5), () {
          requestStatus.value = requestState.isError;
          Dialogs.warningDialog(
            context: Get.context!,
            message: strings.connectionError,
            function: () {
              getProduct();
            },
          );
        });
      }
    } catch (e) {
      requestStatus.value = requestState.isError;
      Logger.printX('Get product failed: $e');
      Dialogs.errorDialog(
        context: Get.context!,
        function: () {},
        message: e.toString(),
      );
    }
  }

  void addToCart() {
    cart.add(product, quantity: countItem.value);
    Dialogs.successDialog(
      context: Get.context!,
      message: 'Successfully added to cart',
      function: () {
        // Get.back();
      },
    );
  }
}

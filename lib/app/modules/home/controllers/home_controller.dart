import 'package:fake_store/app/data/api.dart';
import 'package:fake_store/app/helper/shared/enum.dart';
import 'package:fake_store/app/helper/shared/logger.dart';
import 'package:fake_store/app/helper/shared/string.dart';
import 'package:fake_store/app/helper/widgets/dialogs.dart';
import 'package:fake_store/app/services/check_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeController extends GetxController {
  // Initializing variables
  AppLocalizations get strings => AppLocalizations.of(Get.context!)!;
  final isScrolled = false.obs;
  final requestStatus = requestState.isEmpty.obs;
  final List<dynamic> dataGetProduct = [];

  // Initializing methods
  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getAllHomeData();
    scrollController.addListener(() {
      isScrolled.value =
          scrollController.hasClients && scrollController.offset > 0;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }

  Future<void> getAllHomeData() async {
    bool isConnected = await CheckConnectivity.isConnected();

    if (isConnected) {
      await doGetProduct();
    } else {
      Dialogs.warningDialog(
        context: Get.context!,
        message: strings.connectionError,
        function: () {
          getAllHomeData();
        },
      );
    }
  }

  Future<void> doGetProduct() async {
    requestStatus.value = requestState.isLoading;
    final Api api = Api(storeBaseUrl);

    try {
      final responseGetProduct = await api.get('/products');

      Logger.printInfo('Response Get Product: ${responseGetProduct}');
      if (responseGetProduct['statusCode'] == 200) {
        dataGetProduct.assignAll(
            List<Map<String, dynamic>>.from(responseGetProduct['body']));
        Logger.printInfo('Data Get Product: ${dataGetProduct}');
        requestStatus.value = requestState.isSuccess;
      } else {
        requestStatus.value = requestState.isError;
        Logger.printX(
            'Get product failed with status code: ${responseGetProduct['statusCode']}');
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
}

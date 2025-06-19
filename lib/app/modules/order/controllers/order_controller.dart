import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //Initializing method
  late final TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 6, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

import 'dart:io';

import 'package:fake_store/app/helper/shared/logger.dart';
import 'package:fake_store/app/modules/home/views/home_view.dart';
import 'package:fake_store/app/services/battery_optimizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeMainController extends GetxController {
  // Initializing variables
  RxInt currentIndex = 0.obs;
  List<Widget> pages = [
    const HomeView(),
    const HomeView(),
    const HomeView(),
    const HomeView(),
    const HomeView(),
  ];

  @override
  void onInit() {
    super.onInit();
    _checkBatteryOptimize();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _checkBatteryOptimize() async {
    if (Platform.isAndroid)
      await BatteryOptimizer.checkStatusBatteryOptimizations()
          .then((value) async {
        if (!value) {
          await BatteryOptimizer.requestIgnoreBatteryOptimizations();
        }
      });
  }

  void changeIndex(int index) {
    Logger.printInfo('Current index: $index');
    currentIndex.value = index;
  }
}

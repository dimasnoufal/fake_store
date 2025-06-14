import 'dart:io';

import 'package:fake_store/app/helper/shared/logger.dart';
import 'package:fake_store/app/modules/home/views/home_view.dart';
import 'package:fake_store/app/services/battery_optimizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeMainController extends GetxController {
  // Initializing variabless
  RxInt currentIndex = 0.obs;
  List<Widget> pages = [
    const HomeView(),
    const HomeView(),
    const HomeView(),
    const HomeView(),
    const HomeView(),
  ];

  // Initializinng method
  late final Rx<SharedPreferences?> prefs;

  @override
  void onInit() {
    super.onInit();
    _initPrefs();
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

  Future<void> _initPrefs() async {
    prefs = Rx<SharedPreferences?>(await SharedPreferences.getInstance());
    prefs.value?.setInt('conditionStatePage', 2);
    Logger.printInfo('${prefs.value?.getInt('conditionStatePage')}');
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

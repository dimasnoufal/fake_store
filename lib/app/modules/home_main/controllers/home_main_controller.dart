import 'dart:convert';
import 'dart:io';

import 'package:fake_store/app/helper/shared/logger.dart';
import 'package:fake_store/app/modules/cart/views/cart_view.dart';
import 'package:fake_store/app/modules/favorite/views/favorite_view.dart';
import 'package:fake_store/app/modules/home/views/home_view.dart';
import 'package:fake_store/app/modules/order/views/order_view.dart';
import 'package:fake_store/app/modules/profile/views/profile_view.dart';
import 'package:fake_store/app/services/battery_optimizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeMainController extends GetxController {
  // Initializing variabless
  Map<String, dynamic>? userData;
  RxInt currentIndex = 0.obs;
  List<Widget> pages = [
    const HomeView(),
    const OrderView(),
    const CartView(),
    const FavoriteView(),
    const ProfileView(),
  ];

  // Initializinng method
  late final Rx<SharedPreferences?> prefs;
  final packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '0.0.0',
    buildNumber: '',
  ).obs;

  @override
  void onInit() {
    super.onInit();
    _initPrefs();
    _checkBatteryOptimize();
    _getPackageInfo();
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

    userData =
        jsonDecode(prefs.value!.getString('user')!) as Map<String, dynamic>;

    Logger.printInfo('User Data: $userData');
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

  Future<void> _getPackageInfo() async {
    PackageInfo packagePlatform = await PackageInfo.fromPlatform();
    packageInfo.value = packagePlatform;
  }

  void changeIndex(int index) {
    Logger.printInfo('Current index: $index');
    currentIndex.value = index;
  }

  void showExitDialog() {
    Get.generalDialog(
      barrierLabel: "Exit",
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            width: Get.width * 0.8,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.exit_to_app,
                      size: 40, color: Colors.redAccent),
                  const SizedBox(height: 16),
                  const Text(
                    "Exit App",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Are you sure you want to exit?",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () => exit(0),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                        child: const Text("Exit"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return FadeTransition(
          opacity: anim,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.0).animate(anim),
            child: child,
          ),
        );
      },
    );
  }
}

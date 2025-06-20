import 'dart:convert';
import 'dart:ui';

import 'package:fake_store/app/helper/shared/logger.dart';
import 'package:fake_store/app/routes/app_pages.dart';
import 'package:fake_store/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  // Initializing variables
  RxMap<String, dynamic>? userData = <String, dynamic>{}.obs;
  final isEnglish = false.obs;
  RxBool isRememberMe = false.obs;

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

    userData!.value =
        jsonDecode(prefs.value!.getString('user')!) as Map<String, dynamic>;

    Logger.printInfo('User Data: $userData');

    isEnglish.value = prefs.value?.getBool('isEnglish') ?? false;
    Logger.printInfo('isEnglish: ${isEnglish.value}');

    isRememberMe.value = prefs.value?.getBool('isRememberMe') ?? false;
    Logger.printInfo('isRememberMe: ${isRememberMe.value}');
  }

  Future<void> _getPackageInfo() async {
    PackageInfo packagePlatform = await PackageInfo.fromPlatform();
    packageInfo.value = packagePlatform;
  }

  void changeLanguage() {
    isEnglish.value = !isEnglish.value;
    prefs.value?.setBool('isEnglish', isEnglish.value).then(
          (value) => MyApp.setLocale(
            Get.context!,
            isEnglish.value ? Locale('en') : Locale('id'),
          ),
        );
  }

  void changeBiometric() {
    isRememberMe.value = !isRememberMe.value;
    prefs.value?.setBool('isRememberMe', isRememberMe.value);
  }

  void showLogoutDialog() {
    Get.generalDialog(
      barrierLabel: "Logout",
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
                  const Icon(Icons.warning_amber_rounded,
                      size: 40, color: Colors.redAccent),
                  const SizedBox(height: 16),
                  const Text(
                    "Logout Session",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Are you sure you want to logout?",
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
                        onPressed: () => logout(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                        child: const Text("Logout"),
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

  Future<void> logout() async {
    await prefs.value?.setInt(
      'conditionStatePage',
      1,
    );
    Get.offAllNamed(Routes.LOGIN);
  }
}

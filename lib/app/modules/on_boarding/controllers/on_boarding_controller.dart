import 'package:fake_store/app/routes/app_pages.dart';
import 'package:fake_store/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingController extends GetxController {
  // Initiate variables
  final currentIndex = 0.obs;
  final isEnglish = false.obs;

  // Initiate controller
  final pageController = PageController();

  // Initiate SharedPreferences
  late final Rx<SharedPreferences?> prefs;

  @override
  void onInit() {
    super.onInit();
    // Initiate SharedPreferences
    _initPrefs();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
  }

  Future<void> _initPrefs() async {
    prefs = Rx<SharedPreferences?>(await SharedPreferences.getInstance());
    isEnglish.value = prefs.value?.getBool('isEnglish') ?? false;
    print('isEnglish: ${isEnglish.value}');
  }

  void updateIndex() {
    if (!pageController.hasClients) {
      print('PageController belum attach ke PageView');
      return;
    }

    if (currentIndex.value < 2) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
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
}

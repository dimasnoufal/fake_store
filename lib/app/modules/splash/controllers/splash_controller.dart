import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fake_store/app/helper/shared/common_utils.dart';
import 'package:fake_store/app/helper/shared/logger.dart';
import 'package:fake_store/app/helper/widgets/dialogs.dart';
import 'package:fake_store/app/routes/app_pages.dart';
import 'package:fake_store/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  // Initailize variables
  final strings = AppLocalizations.of(Get.context!);
  final isEnglish = false.obs;

  // Initialze Methods
  final packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '0.0.0',
    buildNumber: '',
  ).obs;

  late final Rx<SharedPreferences?> prefs;

  @override
  void onInit() {
    super.onInit();
    startTime();
    _initPrefs().then((_) {
      changeLanguage();
    });
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
    isEnglish.value = prefs.value?.getBool('isEnglish') ?? false;
    print('isEnglish: ${isEnglish.value}');
  }

  Future<void> startTime() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    print('connectivityResult: $connectivityResult  ');

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      PackageInfo packagePlatform = await PackageInfo.fromPlatform();
      packageInfo.value = packagePlatform;
      await Future.delayed(const Duration(seconds: 2));
      Get.offAllNamed(Routes.ON_BOARDING);
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      Dialogs.warningDialog(
        context: Get.context!,
        message: strings!.connectionError,
        function: () {
          startTime();
        },
      );
    }
  }

  Future<void> changeLanguage() async {
    Future.delayed(
      Duration.zero,
      () {
        if (CommonUtils.falsyChecker(prefs.value?.getBool('isEnglish'))) {
          Logger.printInfo('isEnglish: ${prefs.value?.getBool('isEnglish')}');
          MyApp.setLocale(Get.context!, Locale('id'));
        }
        if (!CommonUtils.falsyChecker(prefs.value?.getBool('isEnglish'))) {
          Logger.printInfo('isEnglish: ${prefs.value?.getBool('isEnglish')}');
          MyApp.setLocale(Get.context!,
              Locale(prefs.value?.getBool('isEnglish') == true ? 'en' : 'id'));
        }
      },
    );
  }
}

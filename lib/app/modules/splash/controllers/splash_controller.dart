import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fake_store/app/helper/dialogs.dart';
import 'package:fake_store/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashController extends GetxController {
  final strings = AppLocalizations.of(Get.context!);
  final packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '0.0.0',
    buildNumber: '',
  ).obs;

  @override
  void onInit() {
    super.onInit();
    startTime();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void startTime() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    print('connectivityResult: $connectivityResult');

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
}

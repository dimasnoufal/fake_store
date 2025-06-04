import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Dialogs {
  static Future<void> warningDialog({
    required BuildContext context,
    String? message,
    required Function() function,
  }) {
    final strings = AppLocalizations.of(context)!;
    return Get.bottomSheet(
      Container(
        width: Get.width,
        height: Get.height * 0.4,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/lottie/warning.json',
                width: 115,
                height: 115,
              ),
              const SizedBox(height: 8.0),
              Text(
                message ?? strings.warning,
                style: AppColor.blackTextStyle.copyWith(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36.0),
              SizedBox(
                width: Get.width * 0.8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColor.kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      side: BorderSide(
                        color: AppColor.kPrimaryColor,
                        width: 1.5,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 20),
                  ),
                  onPressed: () {
                    function();
                    Get.back();
                  },
                  child: Text(strings.tryAgain),
                ),
              ),
            ],
          ),
        ),
      ),
      isDismissible: false,
      enableDrag: false,
    );
  }
}

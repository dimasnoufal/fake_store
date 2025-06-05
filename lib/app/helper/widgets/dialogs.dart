import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Dialogs {
  static Future<void> successDialog({
    required BuildContext context,
    String? message,
    required Function() function,
  }) {
    return Get.generalDialog(
      barrierDismissible: true,
      barrierLabel: 'Success',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );

        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: curved,
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: Get.width * 0.8,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColor.kLightColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColor.kSuccessColor,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        'assets/lottie/success.json',
                        height: 150,
                        repeat: true,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Success',
                        style: const TextStyle(
                          color: AppColor.kSuccessColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      if (message != null)
                        Text(
                          message,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          function();
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.kSuccessColor,
                          foregroundColor: AppColor.kLightColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Tutup',
                          style: AppColor.whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> errorDialog({
    required BuildContext context,
    String? message,
    required Function() function,
  }) {
    return Get.generalDialog(
      barrierDismissible: true,
      barrierLabel: 'Error',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );

        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: curved,
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: Get.width * 0.8,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColor.kLightColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColor.kErrorColor,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        'assets/lottie/error.json',
                        height: 150,
                        repeat: true,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error',
                        style: const TextStyle(
                          color: AppColor.kErrorColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      if (message != null)
                        Text(
                          message,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          function();
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.kErrorColor,
                          foregroundColor: AppColor.kLightColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Tutup',
                          style: AppColor.whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

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

import 'package:fake_store/app/helper/shared/logger.dart';
import 'package:fake_store/app/helper/shared/string.dart';
import 'package:fake_store/app/helper/widgets/dialogs.dart';
// import 'package:fake_store/app/modules/login/controllers/login_controller.dart';
// import 'package:fake_store/app/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterController extends GetxController {
  // Initializing variables
  String? email;
  String? password;
  String? confirmPassword;
  RxBool isHiding = true.obs;
  RxBool isAgreed = false.obs;
  final strings = AppLocalizations.of(Get.context!);

  // Initializing method
  late GlobalKey<FormState> formKey;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final TapGestureRecognizer tosRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer privacyRecognizer = TapGestureRecognizer();
  // final controllerLogin = Get.find<LoginController>();

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    tosRecognizer.onTap = _showTosDialog;
    privacyRecognizer.onTap = _showPrivacyDialog;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    tosRecognizer.dispose();
    privacyRecognizer.dispose();
  }

  bool validateAndSave(BuildContext context) {
    if (!isAgreed.value) {
      Dialogs.errorDialog(
        context: context,
        function: () {},
        message:
            'Setuju terlebih dahulu dengan syarat dan ketentuan', // tambahkan string localization
      );
      return false;
    }

    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }

    Dialogs.errorDialog(
      context: context,
      function: () {},
      message: strings!.messageFormLoginError,
    );
    return false;
  }

  void printEmailAndPassword() {
    email = emailController.text;
    password = passwordController.text;
    confirmPassword = confirmPasswordController.text;
    // Get.delete<LoginController>();
    // Get.offNamed(Routes.LOGIN);
    // controllerLogin.update();
    Get.back();
    Logger.printInfo(
        'Email: $email, Password: $password, Confirm Password: $confirmPassword');
  }

  void changeCheckbox() {
    isAgreed.value = !isAgreed.value;
  }

  void _showTosDialog() {
    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxHeight = MediaQuery.of(context).size.height * 0.75;
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ─── Header ────────────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 12, 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Terms & Conditions',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          splashRadius: 20,
                          icon: const Icon(Icons.close),
                          onPressed: () => Get.back(),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  // ─── Scrollable body ───────────────────────────────────────
                  Expanded(
                    child: Scrollbar(
                      interactive: true,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                        child: Text(
                          kTosContent, // ↓ lihat variabel di bawah
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ),
                  // ─── Action button ─────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => Get.back(),
                        child: Text(strings!.iUnderstand),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      barrierDismissible: false,
      transitionCurve: Curves.easeOutExpo,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  void _showPrivacyDialog() {
    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxHeight = MediaQuery.of(context).size.height * 0.75;
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ─── Header ────────────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 12, 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Privacy Policy',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          splashRadius: 20,
                          icon: const Icon(Icons.close),
                          onPressed: () => Get.back(),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  // ─── Scrollable body ───────────────────────────────────────
                  Expanded(
                    child: Scrollbar(
                      interactive: true,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                        child: Text(
                          kPrivacyPolicyContent, // ↓ lihat variabel di bawah
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ),
                  // ─── Action button ─────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => Get.back(),
                        child: Text(strings!.iUnderstand),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      barrierDismissible: false,
      transitionCurve: Curves.easeOutExpo,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}

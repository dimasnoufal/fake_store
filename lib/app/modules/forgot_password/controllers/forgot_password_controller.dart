import 'package:fake_store/app/helper/shared/logger.dart';
import 'package:fake_store/app/helper/widgets/dialogs.dart';
import 'package:fake_store/app/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordController extends GetxController {
  // Initializing variables
  final strings = AppLocalizations.of(Get.context!);
  String? email;

  // Initializing method
  late GlobalKey<FormState> formKey;
  final emailController = TextEditingController();
  final TapGestureRecognizer tosRegister = TapGestureRecognizer();

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    tosRegister.onTap = _moveToRegister;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    tosRegister.dispose();
  }

  void _moveToRegister() {
    Get.back();
    Get.toNamed(Routes.REGISTER);
  }

  bool validateAndSave(BuildContext context) {
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

  void printEmail() {
    email = emailController.text;

    Get.back();
    Logger.printInfo('Email: $email');
  }
}

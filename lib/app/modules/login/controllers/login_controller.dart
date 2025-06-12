import 'package:fake_store/app/helper/shared/logger.dart';
import 'package:fake_store/app/helper/widgets/dialogs.dart';
import 'package:fake_store/app/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginController extends GetxController {
  // Initializing variables
  String? email;
  String? password;
  RxBool remember = false.obs;
  RxBool isHiding = true.obs;
  AppLocalizations get strings => AppLocalizations.of(Get.context!)!;

  // Initializing method
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late GlobalKey<FormState> formKey;
  late final Rx<SharedPreferences?> prefs;

  @override
  void onInit() {
    super.onInit();
    _initPrefs();
    formKey = GlobalKey<FormState>();
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
  }

  Future<void> _initPrefs() async {
    prefs = Rx<SharedPreferences?>(await SharedPreferences.getInstance());
    prefs.value?.setInt('conditionStatePage', 1);
    Logger.printInfo('${prefs.value?.getInt('conditionStatePage')}');
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
      message: strings.messageFormLoginError,
    );
    return false;
  }

  void printEmailAndPassword() {
    email = emailController.text;
    password = passwordController.text;
    Get.toNamed(Routes.HOME_MAIN);
    Logger.printInfo('Email: $email, Password: $password');
  }
}

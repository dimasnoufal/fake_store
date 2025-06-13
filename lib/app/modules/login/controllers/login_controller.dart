import 'dart:convert';

import 'package:fake_store/app/data/api.dart';
import 'package:fake_store/app/helper/shared/logger.dart';
import 'package:fake_store/app/helper/shared/string.dart';
import 'package:fake_store/app/helper/widgets/dialogs.dart';
import 'package:fake_store/app/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginController extends GetxController {
  // Initializing variables
  String? username;
  String? password;
  RxBool isRememberMe = false.obs;
  RxBool isHiding = true.obs;
  var isLoading = false.obs;
  AppLocalizations get strings => AppLocalizations.of(Get.context!)!;

  // Initializing method
  TextEditingController usernameController = TextEditingController();
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
    usernameController.dispose();
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

  void printUsernameAndPassword() {
    username = usernameController.text;
    password = passwordController.text;
    Logger.printInfo('Username: $username, Password: $password');
  }

  Future<void> doLogin() async {
    isLoading.value = true;
    update();

    var map = new Map<String, dynamic>();
    map['username'] = username!.trim();
    map['password'] = password!.trim();
    // String uri = '${storeBaseUrl}/auth/login';
    // Logger.printInfo('Login URI: $uri');

    try {
      Api apiClient = Api(storeBaseUrl);
      final responseLogin = await apiClient
          .post('/auth/login', map)
          .timeout(const Duration(seconds: 10));

      Logger.printInfo('Login response: ${responseLogin}');
      Logger.printInfo(
          'Info login response: ${responseLogin['statusCode']}, ${responseLogin['body']}');
      if (responseLogin['statusCode'] == 200) {
        Logger.printY('Token: ${responseLogin['body']['token']}');
        prefs.value?.setString('token', responseLogin['body']['token']);
        Logger.printInfo('Token prefs: ${prefs.value?.getString('token')}');
        final user = <String, dynamic>{
          'username': username,
          'password': password,
          'token': responseLogin['body']['token'],
        };
        Logger.printInfo('User data: $user');
        prefs.value?.setString('user', json.encode(user));
        Get.offAllNamed(Routes.HOME_MAIN);
      } else {
        Logger.printX(
            'Login failed with status code: ${responseLogin['statusCode']}');
      }

      // await Future.delayed(const Duration(seconds: 5)).then((_) {
      //   isLoading.value = false;
      //   update();
      // });

      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
      Logger.printX('Login failed: $e');
      Dialogs.errorDialog(
        context: Get.context!,
        function: () {},
        message: e.toString(),
      );
    }
  }
}

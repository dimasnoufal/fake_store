import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:fake_store/app/helper/widgets/custom_innput_obscure.dart';
import 'package:fake_store/app/helper/widgets/custom_input.dart';
import 'package:fake_store/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    Widget buildLogo() {
      return Padding(
        padding: const EdgeInsets.only(top: 42.0),
        child: Container(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/images/ilustration_login.png',
            width: 250,
            height: 250,
          ),
        ),
      );
    }

    Widget buildTitle() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            controller.strings.welcomeMessage,
            style: AppColor.darkGreyTextStyle.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          Text(
            controller.strings.welcomeDescription,
            style: AppColor.lightGreyTextStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      );
    }

    Widget buildFormLogin() {
      return Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Form(
            key: controller.formKey,
            child: Column(
              children: [
                CustomInput(
                  labelText: 'Username',
                  hintText: '${controller.strings.enterYour} username',
                  messageError: 'Username ${controller.strings.cantEmpty}',
                  controller: controller.usernameController,
                  onSaved: (value) => controller.username = value,
                  onChanged: (value) {
                    controller.username = value;
                  },
                ),
                const SizedBox(height: 20),
                Obx(
                  () => CustomInnputObscure(
                    labelText: "Password",
                    hintText: "${controller.strings.enterYour} password",
                    isHiding: controller.isHiding.value,
                    onToggle: () {
                      controller.isHiding.value = !controller.isHiding.value;
                    },
                    messageError1: "Password ${controller.strings.cantEmpty}",
                    messageError2: "Password ${controller.strings.tooShort}",
                    controller: controller.passwordController,
                    onSaved: (value) => controller.password = value,
                    onChanged: (value) {
                      controller.password = value;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.isRememberMe.value,
                        activeColor: AppColor.kPrimaryColor,
                        onChanged: (value) {
                          controller.isRememberMe.value = value!;
                        },
                      ),
                    ),
                    const Text("Remember me"),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.FORGOT_PASSWORD);
                      },
                      child: Text(
                        controller.strings.forgotPassword,
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 36),
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                          child: ElevatedButton(
                            onPressed: () {
                              if (controller.validateAndSave(context)) {
                                controller.printUsernameAndPassword();
                                controller.doLogin();
                              }
                            },
                            child: controller.isLoading.value
                                ? SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 1,
                                    ),
                                  )
                                : Text('Login',
                                    style: AppColor.whiteTextStyle.copyWith(
                                      fontSize: 16,
                                    )),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: controller.isLoadingBiometric.value
                              ? null
                              : controller.doLoginBiometric,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: controller.isLoadingBiometric.value
                                  ? AppColor.kPrimaryColor
                                      .withOpacity(0.6) // Indikasi loading
                                  : AppColor.kPrimaryColor,
                            ),
                            child: Center(
                              child: controller.isLoadingBiometric.value
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.fingerprint,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget buildOptionalLogin() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(12),
            height: 45,
            width: 45,
            decoration: const BoxDecoration(
              color: Color(0xFFF5F6F9),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset('assets/images/google-icon.svg'),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(12),
            height: 45,
            width: 45,
            decoration: const BoxDecoration(
              color: Color(0xFFF5F6F9),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset('assets/images/facebook-2.svg'),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(12),
            height: 45,
            width: 45,
            decoration: const BoxDecoration(
              color: Color(0xFFF5F6F9),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset('assets/images/twitter.svg'),
          ),
        ],
      );
    }

    Widget buildText() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            controller.strings.dontAccount,
            style: AppColor.lightGreyTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
          GestureDetector(
            onTap: () => {
              Get.toNamed(Routes.REGISTER),
            },
            child: Text(
              controller.strings.register,
              style: AppColor.blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLogo(),
              buildTitle(),
              buildFormLogin(),
              const SizedBox(height: 24),
              buildOptionalLogin(),
              const SizedBox(height: 24),
              buildText(),
            ],
          ),
        ),
      ),
    );
  }
}

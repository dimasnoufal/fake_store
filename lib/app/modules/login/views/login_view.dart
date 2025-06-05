import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:fake_store/app/helper/widgets/dialogs.dart';
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
            'Welcome to Store',
            style: AppColor.darkGreyTextStyle.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          Text(
            'Sign in with your email and password or continue with social media',
            style: AppColor.lightGreyTextStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      );
    }

    Widget buildTextInput() {
      return Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Form(
            key: controller.formKey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (newValue) => controller.email = newValue,
                  onChanged: (value) {
                    controller.email = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      Dialogs.errorDialog(
                          context: context,
                          function: () {},
                          message: "Email cannot be empty");
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Enter your email",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    suffixIcon: SizedBox(
                      width: 10,
                      height: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: SvgPicture.asset(
                          'assets/icons/mail.svg',
                          height: 16,
                          width: 16,
                          colorFilter: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              AppColor.kPrimaryColor,
                              BlendMode.srcIn,
                            ),
                          ).colorFilter,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => TextFormField(
                    obscureText: controller.isHiding.value,
                    onSaved: (newValue) => controller.password = newValue,
                    onChanged: (value) {
                      controller.password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        Dialogs.errorDialog(
                            context: context,
                            function: () {},
                            message: "Password cannot be empty");
                      } else if (value.length < 8) {
                        Dialogs.errorDialog(
                            context: context,
                            function: () {},
                            message: "Password is too short");
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your password",
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.isHiding.value =
                              !controller.isHiding.value;
                        },
                        icon: controller.isHiding.value
                            ? const Icon(Icons.visibility_off)
                            : const Icon(
                                Icons.visibility,
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Obx(() => Checkbox(
                          value: controller.remember.value,
                          activeColor: AppColor.kPrimaryColor,
                          onChanged: (value) {
                            controller.remember.value = value!;
                          },
                        )),
                    const Text("Remember me"),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Forgot Password",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 36),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Continue"),
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
            "Don’t have an account? ",
            style: AppColor.lightGreyTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
          GestureDetector(
            onTap: () => {},
            child: Text(
              "Sign Up",
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
              buildTextInput(),
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

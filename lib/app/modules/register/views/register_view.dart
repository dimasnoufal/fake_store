import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:fake_store/app/helper/widgets/custom_innput_obscure.dart';
import 'package:fake_store/app/helper/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    Widget buildTittle() {
      return Center(
        child: Column(
          children: [
            Text(
              '${controller.strings!.register} Accouunt',
              style: AppColor.darkGreyTextStyle.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Complete the form below to create a new account',
              style: AppColor.lightGreyTextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    Widget buildFormRegister() {
      return Form(
        key: controller.formKey,
        child: Column(
          children: [
            CustomInput(
              labelText: 'Email',
              hintText: '${controller.strings!.enterYour} email',
              messageError: 'Email ${controller.strings!.cantEmpty}',
              controller: controller.emailController,
              onSaved: (value) => controller.email = value,
              onChanged: (value) {
                controller.email = value;
              },
            ),
            const SizedBox(height: 20),
            Obx(
              () => CustomInnputObscure(
                labelText: "Password",
                hintText: "${controller.strings!.enterYour} password",
                isHiding: controller.isHiding.value,
                onToggle: () {
                  controller.isHiding.value = !controller.isHiding.value;
                },
                messageError1: "Password ${controller.strings!.cantEmpty}",
                messageError2: "Password ${controller.strings!.tooShort}",
                controller: controller.passwordController,
                onSaved: (value) => controller.password = value,
                onChanged: (value) {
                  controller.password = value;
                },
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => CustomInnputObscure(
                labelText: "Confirmation password",
                hintText:
                    "${controller.strings!.enterYour} Confirmation password",
                isHiding: controller.isHiding.value,
                onToggle: () {
                  controller.isHiding.value = !controller.isHiding.value;
                },
                messageError1:
                    "Confirmation Password ${controller.strings!.cantEmpty}",
                messageError2:
                    "Confirmation password ${controller.strings!.tooShort}",
                controller: controller.confirmPasswordController,
                onSaved: (value) => controller.confirmPassword = value,
                onChanged: (value) {
                  controller.confirmPassword = value;
                },
                extraValidator: (value) {
                  if (value != controller.passwordController.text) {
                    return 'Password dan Konfirmasi Password tidak cocok'; // buatng string localizationnya
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 36),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.validateAndSave(context)) {
                    controller.printEmailAndPassword();
                  }
                },
                child: Text(controller.strings!.login),
              ),
            ),
          ],
        ),
      );
    }

    Widget buildOptionalRegister() {
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
      return Obx(
        () => Row(
          children: [
            Checkbox(
              value: controller.isAgreed.value,
              onChanged: (_) {
                controller.changeCheckbox();
              },
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: 'By registering, you agree to our ',
                  style: AppColor.lightGreyTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Terms of Service',
                      style: AppColor.blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: controller.tosRecognizer,
                    ),
                    TextSpan(
                      text: ' and ',
                      style: AppColor.lightGreyTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: AppColor.blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: controller.privacyRecognizer,
                    ),
                  ],
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      );
    }

    return GetBuilder<RegisterController>(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text(
            controller.strings!.register,
            style: AppColor.blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: AppColor.blackTextStyle.color,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                buildTittle(),
                const SizedBox(height: 24),
                buildFormRegister(),
                const SizedBox(height: 24),
                buildOptionalRegister(),
                const SizedBox(height: 16),
                buildText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

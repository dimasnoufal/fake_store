import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:fake_store/app/helper/widgets/custom_input.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    Widget buildTittle() {
      return Center(
        child: Column(
          children: [
            Text(
              '${controller.strings!.forgotPassword}',
              style: AppColor.darkGreyTextStyle.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Please enter your email to reset your password',
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
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.validateAndSave(context)) {
                    controller.printEmail();
                  }
                },
                child: Text(controller.strings!.forgotPassword),
              ),
            ),
          ],
        ),
      );
    }

    Widget buildText() {
      return Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                text: 'Dont have an account? ',
                style: AppColor.lightGreyTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: controller.strings!.register,
                    style: AppColor.blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: controller.tosRegister,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.strings!.forgotPassword,
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
              buildText(),
            ],
          ),
        ),
      ),
    );
  }
}

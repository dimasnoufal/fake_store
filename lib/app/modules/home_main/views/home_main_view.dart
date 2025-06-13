import 'dart:io';

import 'package:animations/animations.dart';
import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:fake_store/app/helper/shared/logger.dart';
import 'package:fake_store/app/modules/home_main/widget/app_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/home_main_controller.dart';

class HomeMainView extends GetView<HomeMainController> {
  const HomeMainView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopScope(
        canPop: false,
        onPopInvokedWithResult: (value, result) {
          Logger.printInfo(('Pop invoked with result: $result'));
          Logger.printInfo(('Pop invoked with value: $value'));
          Get.defaultDialog(
            title: 'Exit',
            middleText: 'Are you sure you want to exit?',
            textConfirm: 'Yes',
            textCancel: 'No',
            onConfirm: () {
              exit(0);
            },
          );
        },
        child: Scaffold(
          body: SafeArea(
            top: false,
            bottom: true,
            child: PageTransitionSwitcher(
              transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
                return SharedAxisTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                  fillColor: AppColor.kLightColor,
                  child: child,
                );
              },
              duration: const Duration(milliseconds: 300),
              child: controller.pages[controller.currentIndex.value],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.changeIndex(2);
            },
            backgroundColor: AppColor.kPrimaryColor,
            child: SvgPicture.asset('assets/icons/cart.svg',
                colorFilter: ColorFilter.mode(
                  controller.currentIndex.value == 2
                      ? AppColor.kLightColor
                      : AppColor.kSecondaryColor,
                  BlendMode.srcIn,
                )),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AppNavigationBar(
            currentIndex: controller.currentIndex.value,
            onNavTap: controller.changeIndex,
            controller: controller,
          ),
        ),
      ),
    );
  }
}

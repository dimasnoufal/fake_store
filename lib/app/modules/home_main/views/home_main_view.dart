import 'package:animations/animations.dart';
import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:fake_store/app/helper/shared/logger.dart';
import 'package:fake_store/app/helper/widgets/dialogs.dart';
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
          controller.showExitDialog();
        },
        child: Scaffold(
          drawer: NavigationDrawer(
            controller: controller,
          ),
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            onPressed: () {
              controller.changeIndex(2);
            },
            backgroundColor: AppColor.kSecondaryColor,
            child: SvgPicture.asset('assets/icons/cart.svg',
                colorFilter: ColorFilter.mode(
                  controller.currentIndex.value == 2
                      ? AppColor.kLightColor
                      : AppColor.kLightColor.withOpacity(0.5),
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

class NavigationDrawer extends StatelessWidget {
  final HomeMainController controller;
  const NavigationDrawer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: AppColor.kPrimaryColor,
              width: 2,
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Center(
                child: Container(
                  width: 80, // 2 x radius
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColor.kPrimaryColor, // warna border
                      width: 3, // tebal border
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      Scaffold.of(context).closeDrawer();
                      Dialogs.imgDialog(
                        context: context,
                        url: 'assets/images/logo_no_bg.png',
                        width: 400,
                        height: 400,
                      );
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          AssetImage('assets/images/logo_no_bg.png'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  controller.userData?['username'],
                  style: AppColor.blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text(
                  '${controller.userData?['username']}@example.com',
                  style: AppColor.lightGreyTextStyle.copyWith(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              Divider(color: Colors.grey[300]),
              ListTile(
                leading: Icon(Icons.description_outlined,
                    color: AppColor.kPrimaryColor),
                title: Text(
                  'Syarat & Ketentuan',
                  style: AppColor.blackTextStyle.copyWith(fontSize: 16),
                ),
                onTap: () {},
              ),
              ListTile(
                leading:
                    Icon(Icons.info_outline, color: AppColor.kPrimaryColor),
                title: Text(
                  'Versi Aplikasi',
                  style: AppColor.blackTextStyle.copyWith(fontSize: 16),
                ),
                trailing: Text(
                  controller.packageInfo.value.version,
                  style: AppColor.lightGreyTextStyle,
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.feedback_outlined,
                    color: AppColor.kPrimaryColor),
                title: Text(
                  'Feedback & Kritik',
                  style: AppColor.blackTextStyle.copyWith(fontSize: 16),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

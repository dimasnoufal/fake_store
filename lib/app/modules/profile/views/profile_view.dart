import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:fake_store/app/helper/widgets/dialogs.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    Widget _buildBackground() {
      return Container(
        height: 225,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColor.kPrimaryColor.withOpacity(0.2),
              AppColor.kSecondaryColor.withOpacity(0.3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.elliptical(300, 125),
            bottomRight: Radius.elliptical(300, 125),
          ),
        ),
      );
    }

    Widget _buildCardProfile() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 35),
            Container(
              width: Get.size.width,
              margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: InkWell(
                        onTap: () => Dialogs.imgDialog(
                            context: context,
                            height: 400,
                            width: 400,
                            url: 'assets/images/logo_no_bg.png'),
                        child: Container(
                          width: 75,
                          height: 75,
                          color: AppColor.kLightColor,
                          child: CircleAvatar(
                            radius: 37.5,
                            backgroundImage:
                                AssetImage('assets/images/logo_no_bg.png'),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      controller.userData?['username'] ?? 'Nama',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColor.kPrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${controller.userData?['username'] ?? 'nama'}@example.com',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildListCard() {
      Padding cardButton(
          {required BuildContext context,
          required IconData icons,
          required String title,
          required Function onTap,
          Color colorIcon = AppColor.kPrimaryColor,
          Widget? button}) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => onTap(),
              child: ListTile(
                leading: Icon(
                  icons,
                  color: colorIcon,
                  size: 30,
                ),
                title: Text(title),
                trailing: button,
              ),
            ),
          ),
        );
      }

      return Column(
        children: [
          cardButton(
            context: context,
            icons: Icons.person,
            title: 'Profile',
            onTap: () {},
          ),
          cardButton(
            context: context,
            icons: Icons.settings,
            title: 'Settings',
            onTap: () {},
          ),
          cardButton(
            context: context,
            icons: Icons.help,
            title: 'Help',
            onTap: () {},
          ),
          cardButton(
            context: context,
            icons: Icons.notifications,
            title: 'Notifications',
            onTap: () {},
          ),
          cardButton(
            context: context,
            icons: Icons.security,
            title: 'Security',
            onTap: () {},
          ),
          cardButton(
            context: context,
            icons: Icons.fingerprint,
            title: 'Biometric',
            onTap: () {
              controller.changeBiometric();
            },
            button: Obx(
              () => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 80,
                height: 45,
                decoration: BoxDecoration(
                  color: controller.isRememberMe.value
                      ? Colors.black
                      : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey),
                ),
                child: AnimatedAlign(
                  alignment: controller.isRememberMe.value
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    width: 40,
                    height: 35,
                    decoration: BoxDecoration(
                      color: controller.isRememberMe.value
                          ? Colors.white
                          : Colors.black,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        controller.isRememberMe.value ? 'ON' : 'OFF',
                        style: TextStyle(
                          color: controller.isRememberMe.value
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          cardButton(
            context: context,
            icons: Icons.language,
            title: 'Language',
            onTap: () {
              controller.changeLanguage();
            },
            button: Obx(
              () => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 80,
                height: 45,
                decoration: BoxDecoration(
                  color:
                      controller.isEnglish.value ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey),
                ),
                child: AnimatedAlign(
                  alignment: controller.isEnglish.value
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    width: 40,
                    height: 35,
                    decoration: BoxDecoration(
                      color: controller.isEnglish.value
                          ? Colors.white
                          : Colors.black,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        controller.isEnglish.value ? 'EN' : 'ID',
                        style: TextStyle(
                          color: controller.isEnglish.value
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          cardButton(
            context: context,
            icons: Icons.logout,
            title: 'Logout',
            onTap: () {
              controller.showLogoutDialog();
            },
          ),
          cardButton(
            context: context,
            icons: Icons.info,
            title: 'About',
            onTap: () {},
          ),
          cardButton(
            context: context,
            icons: Icons.feedback,
            title: 'Feedback',
            onTap: () {},
          ),
          cardButton(
            context: context,
            icons: Icons.privacy_tip,
            title: 'Privacy Policy',
            onTap: () {},
          ),
        ],
      );
    }

    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) => Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: [
              _buildBackground(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => _buildCardProfile(),
                  ),
                  SizedBox(height: 20),
                  _buildListCard(),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(left: 15, bottom: 10, top: 5),
                    child: Obx(
                      () => Text(
                        'Version App ${controller.packageInfo.value.version}',
                        style: TextStyle(
                          color: AppColor.kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

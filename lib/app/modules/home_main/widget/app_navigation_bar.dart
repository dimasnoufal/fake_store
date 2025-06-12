import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:fake_store/app/modules/home_main/controllers/home_main_controller.dart';
import 'package:fake_store/app/modules/home_main/widget/bottom_app_bar_item.dart';
import 'package:flutter/material.dart';

class AppNavigationBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onNavTap;
  final HomeMainController controller;

  const AppNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onNavTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 14,
      color: AppColor.kPrimaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BottomAppBarItem(
            name: 'Home',
            iconLocation: 'assets/icons/home.svg',
            isActive: currentIndex == 0,
            onTap: () => onNavTap(0),
          ),
          BottomAppBarItem(
            name: 'Order',
            iconLocation: 'assets/icons/order.svg',
            isActive: currentIndex == 1,
            onTap: () => onNavTap(1),
          ),
          const Padding(
            padding: EdgeInsets.all(14 * 2),
            child: SizedBox(width: 14),
          ),

          /* <---- We have to leave this 3rd index (2) for the cart item -----> */

          BottomAppBarItem(
            name: 'Save',
            iconLocation: 'assets/icons/save.svg',
            isActive: currentIndex == 3,
            onTap: () => onNavTap(3),
          ),
          BottomAppBarItem(
            name: 'Profile',
            iconLocation: 'assets/icons/profile.svg',
            isActive: currentIndex == 4,
            onTap: () => onNavTap(4),
          ),
        ],
      ),
    );
  }
}

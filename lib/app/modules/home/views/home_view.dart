import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // AppBar custom (bukan AppBar widget)
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
          child: Row(
            children: [
              Builder(
                builder: (context) => Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColor.kPrimaryColor,
                      width: 2,
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.menu, color: AppColor.kPrimaryColor),
                    iconSize: 20,
                    onPressed: () {
                      final scaffold = Scaffold.maybeOf(context);
                      if (scaffold != null && !scaffold.isDrawerOpen) {
                        scaffold.openDrawer();
                      }
                    },
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'HomeView is working',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        // ...widget lain...
      ],
    );
  }
}

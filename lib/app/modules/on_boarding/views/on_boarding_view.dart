import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:fake_store/app/helper/shared/string.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/on_boarding_controller.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: 3,
                onPageChanged: (index) => controller.currentIndex.value = index,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          items[index].imgPath!,
                          width: 300,
                          height: 300,
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          items[index].tittle!,
                          style: AppColor.darkGreyTextStyle.copyWith(
                            fontSize: 26,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          items[index].subtitle!,
                          style: AppColor.lightGreyTextStyle.copyWith(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(24.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      TweenAnimationBuilder(
                        duration: Duration(milliseconds: 300),
                        tween: Tween<double>(
                            begin: 0,
                            end: (1 / items.length) *
                                (controller.currentIndex.value + 1)),
                        curve: Curves.easeInOutBack,
                        builder: (context, double value, _) => SizedBox(
                          height: 70,
                          width: 70,
                          child: CircularProgressIndicator(
                            value: value,
                            strokeWidth: 6,
                            backgroundColor: AppColor.kLightColor,
                            color: AppColor.kPrimaryColor,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => controller.updateIndex(),
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder()),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

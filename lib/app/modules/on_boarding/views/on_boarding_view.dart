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
                itemCount: items(context).length,
                onPageChanged: (index) => controller.currentIndex.value = index,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          items(context)[index].imgPath!,
                          width: 300,
                          height: 300,
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          items(context)[index].tittle!,
                          style: AppColor.darkGreyTextStyle.copyWith(
                            fontSize: 26,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          items(context)[index].subtitle!,
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
              () => Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      controller.changeLanguage();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 80,
                      height: 45,
                      decoration: BoxDecoration(
                        color: controller.isEnglish.value
                            ? Colors.black
                            : Colors.white,
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
                            end: (1 / items(context).length) *
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

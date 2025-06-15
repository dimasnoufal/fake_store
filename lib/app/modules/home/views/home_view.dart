import 'package:carousel_slider/carousel_slider.dart';
import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildCarouselPromotion() {
      return CarouselSlider(
        items: [
          Image.asset(
            'assets/images/logo.png',
            width: double.infinity,
          ),
          Image.asset(
            'assets/images/logo.png',
            width: double.infinity,
          ),
          Image.asset(
            'assets/images/logo.png',
            width: double.infinity,
          ),
        ],
        options: CarouselOptions(
          height: 100,
          autoPlay: true,
          enableInfiniteScroll: true,
          reverse: false,
          viewportFraction: 1,
        ),
      );
    }

    Widget buildMenu() {
      Widget _buildMenuItem(String iconPath, String title, Function()? onTap) {
        return Column(
          children: [
            Material(
              color: AppColor.kLightColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: AppColor.kPrimaryColor,
                  width: 1,
                ),
              ),
              child: InkWell(
                onTap: () {
                  onTap?.call();
                },
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Center(
                    child: SvgPicture.asset(
                      iconPath,
                      colorFilter: ColorFilter.mode(
                        AppColor.kPrimaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: AppColor.darkGreyTextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }

      return GridView.count(
        crossAxisCount: 5,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 0.9,
        children: [
          _buildMenuItem('assets/icons/cart.svg', 'Flash Deals', () {}),
          _buildMenuItem('assets/icons/cart.svg', 'Bill', () {}),
          _buildMenuItem('assets/icons/cart.svg', 'Game', () {}),
          _buildMenuItem('assets/icons/cart.svg', 'Daily Gift', () {}),
          _buildMenuItem('assets/icons/cart.svg', 'More', () {}),
        ],
      );
    }

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColor.kLightColor,
            floating: false,
            pinned: true,
            iconTheme: IconThemeData(
              color: AppColor.kPrimaryColor,
            ),
            actions: [
              Container(
                width: 200,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.search, color: AppColor.kPrimaryColor),
                    hintText: 'Search...',
                    hintStyle: AppColor.lightGreyTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: const BorderSide(width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColor.kPrimaryColor,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  style: AppColor.darkGreyTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.notifications_none_outlined,
                    color: AppColor.kPrimaryColor),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  buildCarouselPromotion(),
                  const SizedBox(height: 20),
                  buildMenu(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:fake_store/app/helper/shared/enum.dart';
import 'package:fake_store/app/helper/shared/string.dart';
import 'package:fake_store/app/helper/widgets/shimmers.dart';
import 'package:fake_store/app/helper/widgets/state_custom.dart';
import 'package:fake_store/app/modules/home/views/popular_all_view.dart';
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Image.asset(
              'assets/images/banner_promo_1.png',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Image.asset(
              'assets/images/banner_promo_1.png',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Image.asset(
              'assets/images/banner_promo_1.png',
            ),
          ),
        ],
        options: CarouselOptions(
          height: 125,
          autoPlay: true,
          enableInfiniteScroll: true,
          reverse: false,
          viewportFraction: 0.8,
        ),
      );
    }

    Widget buildMenu() {
      Widget _buildMenuItem(String iconPath, String title, Function()? onTap) {
        return Column(
          mainAxisSize: MainAxisSize.min,
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
                onTap: onTap,
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
            const SizedBox(height: 4),
            Text(
              title,
              style: AppColor.darkGreyTextStyle.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        );
      }

      return Container(
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.spaceAround,
          children: [
            _buildMenuItem('assets/icons/flash.svg', 'Flash Deals', () {}),
            _buildMenuItem('assets/icons/bill.svg', 'Bill', () {}),
            _buildMenuItem('assets/icons/game.svg', 'Game', () {}),
            _buildMenuItem('assets/icons/gift.svg', 'Daily Gift', () {}),
            _buildMenuItem('assets/icons/shop.svg', 'More', () {}),
          ],
        ),
      );
    }

    Widget buildSpecial() {
      return Column(
        children: [
          Row(
            children: [
              Text(
                'Special for you',
                style: AppColor.darkGreyTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See all',
                  style: AppColor.lightGreyTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 125,
            child: CustomScrollView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Material(
                            color: Colors.white.withOpacity(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: AppColor.kPrimaryColor,
                                width: 2,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(10),
                              child: Ink.image(
                                image: NetworkImage(backgroundSpecial[index]),
                                fit: BoxFit.cover,
                                width: 300,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  padding: EdgeInsets.all(16),
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tittleSpecial[index],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        subtitleSpecial[index],
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: 3,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget buildPopularProduct() {
      return Column(
        children: [
          Row(
            children: [
              Text(
                'Popular Products',
                style: AppColor.darkGreyTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Get.to(PopularAllView(
                    controller: controller,
                  ));
                },
                child: Text(
                  'See all',
                  style: AppColor.lightGreyTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          controller.requestStatus == requestState.isSuccess &&
                  controller.dataGetProduct.isNotEmpty
              ? SizedBox(
                  height: 200,
                  child: CustomScrollView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SizedBox(
                                width: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Material(
                                        color: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                            color: AppColor.kPrimaryColor,
                                            width: 1,
                                          ),
                                        ),
                                        child: InkWell(
                                          onTap: () {},
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Ink.image(
                                              image: CachedNetworkImageProvider(
                                                controller.dataGetProduct[index]
                                                        ['image'] ??
                                                    '',
                                              ),
                                              fit: BoxFit.contain,
                                              width: 135,
                                              height: 135,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      controller.dataGetProduct[index]
                                              ['title'] ??
                                          'No Title',
                                      style:
                                          AppColor.darkGreyTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      '\$${(controller.dataGetProduct[index]['price'] ?? 0).toStringAsFixed(2)}',
                                      style:
                                          AppColor.darkGreyTextStyle.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: 5,
                        ),
                      ),
                    ],
                  ),
                )
              : controller.requestStatus == requestState.isLoading
                  ? LoadingPopularProducts(
                      count: 5,
                      widthCard: 150,
                      heightCard: 200,
                      baseColor: AppColor.kTertiaryColor,
                      highColor: const Color(0xFFcccccc),
                    )
                  : StateCustom.Empty(
                      title: 'No Popular Products',
                      description:
                          'Currently, there are no popular products available.',
                    ),
        ],
      );
    }

    Widget buildNewProduct() {
      return Column(
        children: [
          Row(
            children: [
              Text(
                'New Products',
                style: AppColor.darkGreyTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See all',
                  style: AppColor.lightGreyTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 300,
            child: CustomScrollView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColor.kPrimaryColor,
                                    width: 1,
                                  ),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  leading: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      // image: DecorationImage(
                                      //   image: NetworkImage(
                                      //     newProduct[index],
                                      //   ),
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: newProduct[index],
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Shimmers.shimmerCustom(
                                        width: 100,
                                        height: 100,
                                        circular: 8,
                                        baseColor: AppColor.kTertiaryColor,
                                        highColor: const Color(0xFFcccccc),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                  title: Text(
                                    tittleNewProduct[index],
                                    style: AppColor.darkGreyTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  subtitle: Text(
                                    priceNewProduct[index],
                                    style: AppColor.darkGreyTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: 5,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return GetBuilder<HomeController>(
      init: HomeController(),
      initState: (_) {},
      builder: (_) {
        return RefreshIndicator(
          displacement: 110,
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2)).then((_) {
              controller.getAllHomeData();
            });
          },
          child: Obx(
            () => CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                SliverAppBar(
                  elevation: 10,
                  forceElevated: controller.isScrolled.value,
                  backgroundColor: AppColor.kLightColor,
                  shadowColor: Colors.black.withOpacity(0.5),
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
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      left: 16,
                      right: 16,
                      bottom: 36,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        buildCarouselPromotion(),
                        const SizedBox(height: 26),
                        buildMenu(),
                        const SizedBox(height: 26),
                        buildSpecial(),
                        const SizedBox(height: 20),
                        buildPopularProduct(),
                        const SizedBox(height: 20),
                        buildNewProduct(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LoadingPopularProducts extends StatelessWidget {
  final int? count;
  final double? widthCard;
  final double? heightCard;
  final Color? baseColor;
  final Color? highColor;
  final Color? backgroundColor;

  const LoadingPopularProducts({
    super.key,
    this.count = 5,
    this.widthCard = 150,
    this.heightCard = 200,
    this.baseColor,
    this.highColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightCard,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: count!,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
              width: widthCard,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Shimmer untuk gambar
                  Shimmers.shimmerCustom(
                    width: widthCard,
                    height: 150,
                    circular: 10,
                    baseColor: baseColor ?? AppColor.kTertiaryColor,
                    highColor: highColor ?? const Color(0xFFcccccc),
                  ),
                  const SizedBox(height: 10),
                  // Shimmer untuk title
                  Shimmers.shimmerCustom(
                    width: 100,
                    height: 12,
                    circular: 4,
                    baseColor: baseColor ?? AppColor.kTertiaryColor,
                    highColor: highColor ?? const Color(0xFFcccccc),
                  ),
                  const SizedBox(height: 6),
                  // Shimmer untuk harga
                  Shimmers.shimmerCustom(
                    width: 60,
                    height: 10,
                    circular: 4,
                    baseColor: baseColor ?? AppColor.kTertiaryColor,
                    highColor: highColor ?? const Color(0xFFcccccc),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

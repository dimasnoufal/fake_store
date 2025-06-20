import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_store/app/data/models/product_item.dart';
import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:fake_store/app/helper/shared/common_utils.dart';
import 'package:fake_store/app/helper/shared/enum.dart';
import 'package:fake_store/app/helper/widgets/dialogs.dart';
import 'package:fake_store/app/helper/widgets/shimmers.dart';
import 'package:fake_store/app/helper/widgets/state_custom.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_item_controller.dart';

class DetailItemView extends GetView<DetailItemController> {
  const DetailItemView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    Widget _buildProductImages(List<dynamic> images) {
      Widget _sampleProductImages(
          {VoidCallback? press, String? image, bool isSelected = false}) {
        return GestureDetector(
          onTap: press,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(8),
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color:
                      AppColor.kPrimaryColor.withOpacity(isSelected ? 1 : 0)),
            ),
            child: CachedNetworkImage(imageUrl: image!),
          ),
        );
      }

      return Obx(
        () => Column(
          children: [
            GestureDetector(
              onTap: () {
                Dialogs.imgDialog(
                  context: context,
                  url: images[controller.selectedImage.value],
                );
              },
              child: SizedBox(
                width: 238,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageUrl: images[controller.selectedImage.value],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  images.length,
                  (index) => _sampleProductImages(
                    press: () {
                      controller.selectedImage.value = index;
                    },
                    image: images[index],
                    isSelected: index == controller.selectedImage.value,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget _buildTopRoundedCorner(
        {Color? color = AppColor.kLightColor, Widget? child}) {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.only(top: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: child,
      );
    }

    Widget _buildProductDescription(
        {ProductItem? productItem, GestureTapCallback? pressOnSeeMore}) {
      return Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                productItem!.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.all(16),
                width: 48,
                decoration: BoxDecoration(
                  color: controller.isFav.value
                      ? const Color(0xFFFFE6E6)
                      : const Color(0xFFF5F6F9),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        controller.toggleFavorite();
                      },
                      child: Icon(
                        controller.isFav.value
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: const Color(0xFFFF4848),
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 64,
              ),
              child: Text(
                '\$${productItem.price.toString()}',
                style: AppColor.darkGreyTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: controller.isShowMore.value ? null : 3,
                overflow:
                    controller.isShowMore.value ? null : TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 64,
              ),
              child: Text(
                productItem.description,
                maxLines: controller.isShowMore.value ? null : 3,
                overflow:
                    controller.isShowMore.value ? null : TextOverflow.ellipsis,
              ),
            ),
            if (controller.showSeeMore.value)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: controller.isShowMore == true
                    ? GestureDetector(
                        onTap: () {
                          controller.isShowMore.value =
                              !controller.isShowMore.value;
                        },
                        child: const Row(
                          children: [
                            Text(
                              "See More less",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.kPrimaryColor),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: AppColor.kPrimaryColor,
                            ),
                          ],
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          controller.isShowMore.value =
                              !controller.isShowMore.value;
                        },
                        child: const Row(
                          children: [
                            Text(
                              "See More Detail",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.kPrimaryColor),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: AppColor.kPrimaryColor,
                            ),
                          ],
                        ),
                      ),
              )
          ],
        ),
      );
    }

    Widget _buildColorDots(Product product) {
      Widget _buildColorDot(Color color, bool isSelected, VoidCallback onTap) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(right: 2),
            padding: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                  color:
                      isSelected ? AppColor.kPrimaryColor : Colors.transparent),
              shape: BoxShape.circle,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(
          () => Row(
            children: [
              ...List.generate(
                product.colors.length,
                (index) => _buildColorDot(
                  product.colors[index],
                  index == controller.selectedColor.value,
                  () {
                    controller.selectedColor.value = index;
                  },
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      controller.removeItem();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(
                        side: BorderSide(
                          color: AppColor.kPrimaryColor,
                          width: 1.5,
                        ),
                      ),
                      padding: EdgeInsets.zero,
                      backgroundColor: AppColor.kLightColor,
                      overlayColor: AppColor.kPrimaryColor.withOpacity(0.5),
                    ),
                    child: const Icon(
                      Icons.remove,
                      color: AppColor.kPrimaryColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                    child: Center(
                      child: Text(
                        controller.countItem.value.toString(),
                        style: AppColor.blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.addItem();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(
                        side: BorderSide(
                          color: AppColor.kPrimaryColor,
                          width: 1.5,
                        ),
                      ),
                      padding: EdgeInsets.zero,
                      backgroundColor: AppColor.kLightColor,
                      overlayColor: AppColor.kPrimaryColor.withOpacity(0.5),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: AppColor.kPrimaryColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Obx(
      () => controller.requestStatus == requestState.isSuccess &&
              !CommonUtils.falsyChecker(controller.dataGetProduct)
          ? Scaffold(
              extendBody: true,
              extendBodyBehindAppBar: true,
              backgroundColor: const Color(0xFFF5F6F9),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: EdgeInsets.zero,
                      elevation: 0,
                      backgroundColor: Colors.white,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
                actions: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Text(
                              controller.dataGetProduct.rating.rate.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.star,
                              color: AppColor.kPrimaryColor.withOpacity(0.8),
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              body: ListView(
                children: [
                  _buildProductImages(controller.image),
                  _buildTopRoundedCorner(
                    color: Colors.white,
                    child: Column(
                      children: [
                        _buildProductDescription(
                          productItem: controller.dataGetProduct,
                          pressOnSeeMore: () {},
                        ),
                        _buildTopRoundedCorner(
                          color: const Color(0xFFF6F7F9),
                          child: Column(
                            children: [
                              _buildColorDots(sampleProduct),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: _buildTopRoundedCorner(
                color: Colors.white,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Icon(
                            Icons.add_shopping_cart_sharp,
                            color: AppColor.kLightColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text("Checkout"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : controller.requestStatus == requestState.isLoading
              ? Scaffold(
                  backgroundColor: const Color(0xFFF5F6F9),
                  body: LoadingDetailProduct(
                    baseColor: AppColor.kTertiaryColor,
                    highColor: const Color(0xFFcccccc),
                  ),
                )
              : Scaffold(
                  backgroundColor: const Color(0xFFF5F6F9),
                  body: Center(
                    child: StateCustom.Empty(
                      title: 'No Popular Products',
                      description:
                          'Currently, there are no popular products available.',
                    ),
                  ),
                ),
    );
  }
}

class LoadingDetailProduct extends StatelessWidget {
  final Color? baseColor;
  final Color? highColor;

  const LoadingDetailProduct({
    super.key,
    this.baseColor,
    this.highColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Shimmers.shimmerCustom(
            width: 40,
            height: 40,
            circular: 40,
            baseColor: baseColor ?? AppColor.kTertiaryColor,
            highColor: highColor ?? const Color(0xFFcccccc),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Shimmers.shimmerCustom(
              width: 50,
              height: 20,
              circular: 14,
              baseColor: baseColor ?? AppColor.kTertiaryColor,
              highColor: highColor ?? const Color(0xFFcccccc),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Gambar produk besar
          Shimmers.shimmerCustom(
            width: double.infinity,
            height: 320,
            circular: 0,
            baseColor: baseColor ?? AppColor.kTertiaryColor,
            highColor: highColor ?? const Color(0xFFcccccc),
          ),

          const SizedBox(height: 20),

          // Deskripsi & Info produk
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmers.shimmerCustom(
                  width: 220,
                  height: 18,
                  circular: 6,
                  baseColor: baseColor ?? AppColor.kTertiaryColor,
                  highColor: highColor ?? const Color(0xFFcccccc),
                ),
                const SizedBox(height: 12),
                Shimmers.shimmerCustom(
                  width: double.infinity,
                  height: 14,
                  circular: 4,
                  baseColor: baseColor ?? AppColor.kTertiaryColor,
                  highColor: highColor ?? const Color(0xFFcccccc),
                ),
                const SizedBox(height: 8),
                Shimmers.shimmerCustom(
                  width: double.infinity,
                  height: 14,
                  circular: 4,
                  baseColor: baseColor ?? AppColor.kTertiaryColor,
                  highColor: highColor ?? const Color(0xFFcccccc),
                ),
                const SizedBox(height: 16),

                // Simulasi color dots / option
                Row(
                  children: List.generate(4, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Shimmers.shimmerCustom(
                        width: 36,
                        height: 36,
                        circular: 18,
                        baseColor: baseColor ?? AppColor.kTertiaryColor,
                        highColor: highColor ?? const Color(0xFFcccccc),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),

      // Bottom checkout button
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: SafeArea(
          child: Row(
            children: [
              Shimmers.shimmerCustom(
                width: 48,
                height: 48,
                circular: 24,
                baseColor: baseColor ?? AppColor.kTertiaryColor,
                highColor: highColor ?? const Color(0xFFcccccc),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Shimmers.shimmerCustom(
                  width: double.infinity,
                  height: 48,
                  circular: 12,
                  baseColor: baseColor ?? AppColor.kTertiaryColor,
                  highColor: highColor ?? const Color(0xFFcccccc),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

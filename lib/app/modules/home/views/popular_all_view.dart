import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:fake_store/app/helper/shared/enum.dart';
import 'package:fake_store/app/helper/widgets/shimmers.dart';
import 'package:fake_store/app/helper/widgets/state_custom.dart';
import 'package:fake_store/app/modules/home/controllers/home_controller.dart';
import 'package:fake_store/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';

class PopularAllView extends GetView {
  final HomeController controller;
  const PopularAllView({
    super.key,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColor.kPrimaryColor),
        elevation: 0,
        title: Text(
          'Popular Products',
          style: AppColor.blackTextStyle.copyWith(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (controller.requestStatus.value == requestState.isSuccess &&
              controller.dataGetProduct.isNotEmpty) {
            return RefreshIndicator(
              displacement: 90,
              onRefresh: controller.doGetProduct,
              child: MasonryGridView.count(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                itemCount: controller.dataGetProduct.length,
                itemBuilder: (context, index) {
                  final product =
                      controller.dataGetProduct[index] as Map<String, dynamic>;
                  final price = (product['price'] as num?)?.toDouble() ?? 0.0;

                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: double.infinity,
                          height: index.isEven ? 200 : 150,
                          child: Material(
                            color: Colors.white.withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: AppColor.kPrimaryColor,
                                width: 2,
                              ),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                Get.toNamed(
                                  '${Routes.DETAIL_ITEM}/${product['id']}',
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Ink.image(
                                  image: NetworkImage(
                                    product['image'] ?? '',
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['title'] ?? 'No Title',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppColor.darkGreyTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${price.toStringAsFixed(2)}',
                              style: AppColor.darkGreyTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          } else if (controller.requestStatus.value == requestState.isLoading) {
            return LoadingPopularGrid(
              itemCount: controller.dataGetProduct.length,
            );
          } else {
            return StateCustom.Empty(
              title: 'No Popular Products',
              description:
                  'Currently, there are no popular products available.',
            );
          }
        },
      ),
    );
  }
}

class LoadingPopularGrid extends StatelessWidget {
  final int itemCount;
  final Color? baseColor;
  final Color? highColor;

  const LoadingPopularGrid({
    super.key,
    this.itemCount = 6,
    this.baseColor,
    this.highColor,
  });

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Column(
          children: [
            // shimmer gambar
            Shimmers.shimmerCustom(
              width: double.infinity,
              height: index.isEven ? 200 : 150,
              circular: 10,
              baseColor: baseColor ?? AppColor.kTertiaryColor,
              highColor: highColor ?? const Color(0xFFcccccc),
            ),
            const SizedBox(height: 8),

            // shimmer judul
            Shimmers.shimmerCustom(
              width: double.infinity,
              height: 14,
              circular: 4,
              baseColor: baseColor ?? AppColor.kTertiaryColor,
              highColor: highColor ?? const Color(0xFFcccccc),
            ),
            const SizedBox(height: 6),

            // shimmer harga
            Align(
              alignment: Alignment.centerLeft,
              child: Shimmers.shimmerCustom(
                width: 60,
                height: 12,
                circular: 4,
                baseColor: baseColor ?? AppColor.kTertiaryColor,
                highColor: highColor ?? const Color(0xFFcccccc),
              ),
            ),
          ],
        );
      },
    );
  }
}

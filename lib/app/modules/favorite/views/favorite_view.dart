import 'package:fake_store/app/data/models/product_item.dart';
import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:fake_store/app/helper/widgets/state_custom.dart';
import 'package:fake_store/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({super.key});
  @override
  Widget build(BuildContext context) {
    Widget _buildFavoriteCard(Product p) {
      return Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Get.toNamed('${Routes.DETAIL_ITEM}/${p.id}');
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: AppColor.kPrimaryColor,
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 88,
                  child: AspectRatio(
                    aspectRatio: 0.88,
                    child: Ink(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Ink.image(
                        image: NetworkImage(p.images[0]),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width * 0.6,
                      child: Text(
                        p.title,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        text: "\$${p.price}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColor.kPrimaryColor),
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

    return GetBuilder<FavoriteController>(
      init: FavoriteController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Favorite',
            style: AppColor.darkGreyTextStyle.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Obx(
          () => controller.fav.favorites.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: controller.fav.favorites.values
                        .map(
                          (p) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Dismissible(
                              key: Key(p.id.toString()),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                controller.fav.toggle(p);
                              },
                              background: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFE6E6),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    SvgPicture.asset(
                                      "assets/icons/trash.svg",
                                      colorFilter: ColorFilter.mode(
                                        AppColor.kErrorColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              child: _buildFavoriteCard(p),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )
              : StateCustom.Empty(
                  title: 'No Favorites',
                  description:
                      'You have not added any products to your favorites yet.',
                ),
        ),
      ),
    );
  }
}

import 'package:fake_store/app/data/models/cart_item.dart';
import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:fake_store/app/helper/widgets/state_custom.dart';
import 'package:fake_store/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});
  @override
  Widget build(BuildContext context) {
    Widget _buildCartCard(CartItem cart, int index) {
      return Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Get.toNamed('${Routes.DETAIL_ITEM}/${cart.product.id}');
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
                        image: NetworkImage(
                          cart.product.images[0],
                        ),
                        fit: BoxFit.contain,
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
                        cart.product.title,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: Get.width * 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "\$${cart.product.price}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.kPrimaryColor),
                            ),
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (controller.cart.items[index].quantity >
                                      1) {
                                    controller.decrementQty(
                                      cart.product,
                                      1,
                                    );
                                  }
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
                                  overlayColor:
                                      AppColor.kPrimaryColor.withOpacity(0.5),
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  color: AppColor.kPrimaryColor,
                                  size: 20,
                                ),
                              ),
                              Obx(
                                () => SizedBox(
                                  width: 20,
                                  child: Center(
                                    child: Text(
                                      controller.cart.items[index].quantity
                                          .toString(),
                                      style: AppColor.blackTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  controller.incrementQty(cart.product, 1);
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
                                  overlayColor:
                                      AppColor.kPrimaryColor.withOpacity(0.5),
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
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildCheckoutCard() {
      return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -15),
              blurRadius: 20,
              color: const Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.location_on_outlined,
                      color: AppColor.kDarkColor,
                    ),
                  ),
                  const Spacer(),
                  const Text("Add shipping address"),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: AppColor.kDarkColor,
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/receipt.svg",
                      colorFilter: ColorFilter.mode(
                        AppColor.kDarkColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Text("Add voucher code"),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: AppColor.kDarkColor,
                  )
                ],
              ),
              const SizedBox(height: 16),
              Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: "Total:\n",
                          children: [
                            TextSpan(
                              text: "\$${controller.cart.total}",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    controller.cart.items.isNotEmpty
                        ? Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed(
                                  Routes.CHECKOUT,
                                  arguments: controller.cart.items.toList(),
                                );
                              },
                              child: const Text("Check Out"),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GetBuilder<CartController>(
      init: CartController(),
      builder: (controller) => Obx(
        () => Scaffold(
          appBar: AppBar(
            title: Column(
              children: [
                const Text(
                  "Your Cart",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  "${controller.cart.items.length} items",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: controller.cart.items.isNotEmpty
                  ? ListView.builder(
                      itemCount: controller.cart.items.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Dismissible(
                          key: Key(controller.cart.items[index].product.id
                              .toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            controller.cart.removeOne(
                              controller.cart.items[index].product,
                              quantity: controller.cart.items[index].quantity,
                            );
                          },
                          background: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          child: _buildCartCard(
                              controller.cart.items[index], index),
                        ),
                      ),
                    )
                  : StateCustom.Empty(
                      title: "Your cart is empty",
                      description: "Add items to your cart to proceed.",
                    )),
          bottomNavigationBar: _buildCheckoutCard(),
        ),
      ),
    );
  }
}

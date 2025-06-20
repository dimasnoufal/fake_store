import 'package:fake_store/app/data/models/cart_item.dart';
import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});
  @override
  Widget build(BuildContext context) {
    Widget _buildCartCard(Cart cart) {
      return Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {},
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
                        image: AssetImage(cart.product.images[0]),
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
                    Text.rich(
                      TextSpan(
                        text: "\$${cart.product.price}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColor.kPrimaryColor),
                        children: [
                          TextSpan(
                              text: " x ${cart.numOfItem}",
                              style: Theme.of(context).textTheme.bodyLarge),
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
              Row(
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: "Total:\n",
                        children: [
                          TextSpan(
                            text: "\$${controller.totalPrice}",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Check Out"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return GetBuilder<CartController>(
      init: CartController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              const Text(
                "Your Cart",
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "${demoCarts.length} items",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
            itemCount: demoCarts.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Dismissible(
                key: Key(demoCarts[index].product.id.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {},
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
                child: _buildCartCard(demoCarts[index]),
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildCheckoutCard(),
      ),
    );
  }
}

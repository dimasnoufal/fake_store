import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      init: OrderController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text('Order Process',
              style: AppColor.darkGreyTextStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          bottom: TabBar(
            controller: controller.tabController,
            tabs: const [
              Tab(text: 'Pending'),
              Tab(text: 'Shipped'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: TabBarView(
          controller: controller.tabController,
          children: const [
            Center(child: Text('Pending Orders')),
            Center(child: Text('Shipped Orders')),
            Center(child: Text('Completed Orders')),
          ],
        ),
      ),
    );
  }
}

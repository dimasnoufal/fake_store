import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});
  @override
  Widget build(BuildContext context) {
    Widget _buildAddressContainer() {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: AppColor.kDarkColor,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: 'Dimas Noufal',
                      style: AppColor.blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: '  (+62)896-1234-5678',
                          style: AppColor.lightGreyTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '123 Main St, Springfield, USA',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppColor.blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColor.kSecondaryColor.withOpacity(0.5),
              ),
              onPressed: () {},
            ),
          ],
        ),
      );
    }

    Widget _buildListCheckout() {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.args.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = controller.args[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: Image.network(
                item.product.images[0],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(
                item.product.title,
                style: AppColor.blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                'Quantity: ${item.quantity}',
                style: AppColor.lightGreyTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: Text(
                '\$${(item.product.price * item.quantity).toStringAsFixed(2)}',
                style: AppColor.darkGreyTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      );
    }

    Widget _buildVoucherInfo({bool isUsed = false, String? voucherCode}) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isUsed ? Colors.green.shade50 : Colors.orange.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isUsed ? Colors.green : Colors.orange,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.card_giftcard,
              color: isUsed ? Colors.green : Colors.orange,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: isUsed
                  ? Text(
                      "Voucher terpakai: ${voucherCode ?? '-'}",
                      style: TextStyle(
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Text(
                      "Punya kode voucher?",
                      style: TextStyle(
                        color: Colors.orange.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
            isUsed
                ? const Icon(Icons.check_circle, color: Colors.green)
                : TextButton(
                    onPressed: () {},
                    child: Text(
                      "Pakai",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ],
        ),
      );
    }

    Widget _buildPaymentMethod() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(Icons.credit_card, color: AppColor.kDarkColor),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                controller.paymentName.isEmpty
                    ? 'Pilih metode pembayaran'
                    : controller.paymentName,
                style: AppColor.blackTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.kSecondaryColor.withOpacity(0.5),
            ),
          ],
        ),
      );
    }

    Widget _buildDetailPayment() {
      Widget _row(String label, double value, {bool isTotal = false}) {
        final style = isTotal
            ? AppColor.blackTextStyle
                .copyWith(fontSize: 16, fontWeight: FontWeight.w600)
            : AppColor.darkGreyTextStyle
                .copyWith(fontSize: 14, fontWeight: FontWeight.w400);
        final valueText =
            (value < 0 ? '- ' : '') + '\$${value.abs().toStringAsFixed(2)}';
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: style),
              Text(valueText, style: style),
            ],
          ),
        );
      }

      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            _row('Subtotal', controller.subtotal),
            _row('Diskon', -controller.discount),
            _row('Ongkir', controller.shipping),
            const Divider(height: 24),
            _row('Total', controller.total, isTotal: true),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Checkout',
          style: AppColor.blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: AppColor.blackTextStyle.color,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildAddressContainer(),
                const SizedBox(height: 16),
                _buildListCheckout(),
                const SizedBox(height: 16),
                _buildVoucherInfo(
                  isUsed: false,
                ),
                _buildPaymentMethod(),
                _buildDetailPayment(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.kPrimaryColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            'Checkout',
            style: AppColor.whiteTextStyle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

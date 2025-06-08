import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomInput extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String messageError;
  final TextEditingController? controller;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;

  const CustomInput({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.messageError,
    required this.controller,
    required this.onSaved,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => onSaved,
      onChanged: (value) {
        onChanged;
      },
      validator: (value) {
        return (value == null || value.isEmpty) ? messageError : null;
      },
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: AppColor.lightGreyTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          gapPadding: 8,
          borderSide: const BorderSide(width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          gapPadding: 8,
          borderSide: BorderSide(
            width: 1,
            color: AppColor.kPrimaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          gapPadding: 8,
          borderSide: BorderSide(
            width: 1,
            color: AppColor.kErrorColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          gapPadding: 8,
          borderSide: BorderSide(
            width: 1,
            color: AppColor.kErrorColor,
          ),
        ),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        suffixIcon: SizedBox(
          width: 10,
          height: 10,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: SvgPicture.asset(
              'assets/icons/mail.svg',
              height: 16,
              width: 16,
              colorFilter: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  AppColor.kPrimaryColor,
                  BlendMode.srcIn,
                ),
              ).colorFilter,
            ),
          ),
        ),
      ),
    );
  }
}

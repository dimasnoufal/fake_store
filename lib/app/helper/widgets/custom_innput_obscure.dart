import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:flutter/material.dart';

class CustomInnputObscure extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String? receiveErrorMessage;
  final bool isHiding;
  final VoidCallback onToggle;
  final String messageError1;
  final String messageError2;
  final TextEditingController? controller;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  const CustomInnputObscure({
    super.key,
    required this.labelText,
    required this.hintText,
    this.receiveErrorMessage,
    required this.isHiding,
    required this.onToggle,
    required this.messageError1,
    required this.messageError2,
    required this.controller,
    required this.onSaved,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isHiding,
      onSaved: (newValue) => onSaved,
      onChanged: (value) {
        onChanged;
      },
      validator: (value) {
        if (value == null || value.isEmpty) return messageError1;
        if (value.length < 8) return messageError2;
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
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
        suffixIcon: IconButton(
          onPressed: () {
            onToggle();
          },
          icon: isHiding
              ? const Icon(Icons.visibility_off,
                  color: AppColor.kSecondaryColor)
              : const Icon(
                  Icons.visibility,
                  color: AppColor.kSecondaryColor,
                ),
        ),
      ),
    );
  }
}

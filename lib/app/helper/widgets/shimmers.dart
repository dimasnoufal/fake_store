import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Shimmers {
  static Widget shimmerCustom(
      {double? width,
      double? height,
      double? circular,
      Color? baseColor,
      Color? highColor}) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? AppColor.kTertiaryColor,
      highlightColor: highColor ?? Color(0xFFcccccc),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(circular ?? 10)),
      ),
    );
  }
}

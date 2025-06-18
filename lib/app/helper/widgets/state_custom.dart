import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StateCustom {
  static Widget Empty({String? title, String? description}) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/lottie/empty.json',
          repeat: true,
          height: 100,
          width: 100,
        ),
        Text(
          '$title',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColor.kPrimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        Text(
          description ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColor.kTertiaryColor),
        )
      ],
    ));
  }
}

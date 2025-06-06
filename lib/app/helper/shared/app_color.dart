import 'package:flutter/material.dart';

class AppColor {
  // Primary colors
  static const kPrimaryColor = Color(0xFF292526);
  static const kSecondaryColor = Color(0xFF787676);
  static const kTertiaryColor = Color(0xFFA3A1A2);
  static const kLightColor = Color(0xFFF2F2F2);
  static const kDarkColor = Color(0xFF121111);

  // Accent colors
  static const kSuccessColor = Color(0xFF21BF73);
  static const kErrorColor = Color(0xFFF7323F);
  static const kWarningColor = Color(0xFFFF9800);

  // Text styles
  static TextStyle blackTextStyle = TextStyle(
    fontFamily: 'EncodeSans',
    color: kDarkColor,
  );

  static TextStyle whiteTextStyle = TextStyle(
    fontFamily: 'EncodeSans',
    color: kLightColor,
  );

  static TextStyle darkGreyTextStyle = TextStyle(
    fontFamily: 'EncodeSans',
    color: kSecondaryColor,
  );

  static TextStyle lightGreyTextStyle = TextStyle(
    fontFamily: 'EncodeSans',
    color: kTertiaryColor,
  );

  // Theme colors
  static ThemeData mainScheme = ThemeData(
    fontFamily: 'EncodeSans',
    scaffoldBackgroundColor: AppColor.kLightColor,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColor.kPrimaryColor,
      onPrimary: Colors.white,
      secondary: AppColor.kSecondaryColor,
      onSecondary: Colors.white,
      error: AppColor.kErrorColor,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.kPrimaryColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    dialogTheme: const DialogTheme(
      surfaceTintColor: Colors.transparent,
    ),
    datePickerTheme: const DatePickerThemeData(
      rangePickerSurfaceTintColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.kPrimaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      ),
    ),
  );
}

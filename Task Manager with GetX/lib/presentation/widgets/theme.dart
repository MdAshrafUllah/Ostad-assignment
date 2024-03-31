import 'package:flutter/material.dart';
import 'package:taskmanager/presentation/utils/app_colors.dart';

ThemeData themeStyle() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColor.themeColor),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColor.whiteColor,
      filled: true,
      hintStyle: const TextStyle(color: AppColor.greyColor),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: AppColor.themeColor,
        foregroundColor: AppColor.whiteColor,
        padding: const EdgeInsets.all(12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          foregroundColor: AppColor.themeColor,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          )),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          color: AppColor.textPrimaryColor,
          fontSize: 32,
          fontWeight: FontWeight.w600),
      displaySmall: TextStyle(
          color: AppColor.textPrimaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w600),
      bodySmall: TextStyle(
          color: AppColor.greyColor, fontSize: 16, fontWeight: FontWeight.w600),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColor.themeColor,
    ),
  );
}

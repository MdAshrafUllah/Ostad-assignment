import 'package:ecommerce_app/application/utility/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData lightThemeDataStyle() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.foregroundColor,
        padding: const EdgeInsets.symmetric(vertical: 12),
        textStyle: const TextStyle(
            fontSize: 16, letterSpacing: 0.5, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.greyColor,
        ),
      ),
      filled: true,
      fillColor: AppColors.greyShade200Color,
      prefixIconColor: AppColors.blackColor.withOpacity(0.6),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.foregroundColor,
      elevation: 1,
      foregroundColor: AppColors.blackColor.withOpacity(0.6),
      shadowColor: AppColors.greyColor.withOpacity(0.5),
    ),
  );
}

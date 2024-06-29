import 'package:ecommerce_app/application/utility/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData darkThemeDataStyle() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      brightness: Brightness.dark,
    ),
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
      filled: true,
      fillColor: AppColors.white10Color,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.greyColor),
      ),
      prefixIconColor: AppColors.greyShade200Color.withOpacity(0.8),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.transparentColor,
      foregroundColor: AppColors.greyShade200Color.withOpacity(0.8),
    ),
  );
}

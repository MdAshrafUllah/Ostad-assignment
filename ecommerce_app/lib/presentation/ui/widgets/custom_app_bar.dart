import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ecommerce_app/application/utility/app_colors.dart';
import 'package:ecommerce_app/presentation/state_holders/main_bottom_nav_screen_controller.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final double elevation;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.elevation,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: backgroundColor == null
              ? null
              : AppColors.blackColor.withOpacity(0.6),
        ),
      ),
      backgroundColor: backgroundColor,
      elevation: elevation,
      shadowColor: elevation == 0
          ? AppColors.transparentColor
          : AppColors.greyShade200Color,
      leading: IconButton(
        onPressed: () {
          if (title == "Categories" || title == "Cart" || title == "WishList") {
            Get.find<MainBottomNavScreenController>().changeScreen(0);
          } else {
            Get.back();
          }
        },
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.greyColor,
        ),
      ),
    );
  }
}

import 'package:ecommerce_app/application/utility/app_colors.dart';
import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  const CircularIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.backgroundColor,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: CircleAvatar(
        radius: 14,
        backgroundColor: backgroundColor,
        child: Icon(
          icon,
          color: AppColors.greyColor,
          size: 16,
        ),
      ),
    );
  }
}

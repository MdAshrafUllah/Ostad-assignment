import 'package:ecommerce_app/application/utility/app_colors.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.icon,
  });
  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null)
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: AppColors.greyColor.withOpacity(0.2),
              child: Icon(
                icon,
                color: AppColors.greyColor,
                size: 20,
              ),
            ),
          ),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

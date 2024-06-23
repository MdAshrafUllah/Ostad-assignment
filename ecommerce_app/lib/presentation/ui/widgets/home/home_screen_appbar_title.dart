// ignore_for_file: unrelated_type_equality_checks

import 'package:ecommerce_app/application/utility/app_colors.dart';
import 'package:ecommerce_app/presentation/state_holders/auth/read_profile_controller.dart';
import 'package:ecommerce_app/presentation/state_holders/theme_controller.dart';
import 'package:ecommerce_app/presentation/ui/screens/profile_screen.dart';
import 'package:ecommerce_app/presentation/ui/utility/assets_path.dart';
import 'package:ecommerce_app/presentation/ui/widgets/circular_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreenAppBarTitle extends StatefulWidget {
  const HomeScreenAppBarTitle({super.key});

  @override
  State<HomeScreenAppBarTitle> createState() => _HomeScreenAppBarTitleState();
}

class _HomeScreenAppBarTitleState extends State<HomeScreenAppBarTitle> {
  final ThemeController themeController = Get.put(ThemeController());
  final String phoneNumber = "+8801627263747";
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          AssetsPath.appNavLogoSVG,
        ),
        const Spacer(),
        CircularIconButton(
          backgroundColor: themeController.currentThemeMode == ThemeMode.light
              ? AppColors.blackColor.withOpacity(0.1)
              : AppColors.white10Color,
          icon: Icons.person_outline_rounded,
          onTap: () async {
            await Get.find<ReadProfileController>().readProfileData();
            Get.to(() => const UserProfileScreen());
          },
        ),
        const SizedBox(
          width: 8,
        ),
        Transform.rotate(
          angle: 180,
          child: CircularIconButton(
            backgroundColor: themeController.currentThemeMode == ThemeMode.light
                ? AppColors.blackColor.withOpacity(0.1)
                : AppColors.white10Color,
            icon: Icons.call_end_outlined,
            onTap: () {
              launchUrlString("tel://$phoneNumber ");
            },
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        CircularIconButton(
          backgroundColor: themeController.currentThemeMode == ThemeMode.light
              ? AppColors.blackColor.withOpacity(0.1)
              : AppColors.white10Color,
          icon: Icons.notifications_active_outlined,
          onTap: () {},
        ),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }
}

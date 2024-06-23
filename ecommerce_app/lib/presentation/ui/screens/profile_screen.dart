import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:ecommerce_app/application/utility/app_colors.dart';
import 'package:ecommerce_app/presentation/state_holders/auth/auth_controller.dart';
import 'package:ecommerce_app/presentation/state_holders/auth/read_profile_controller.dart';
import 'package:ecommerce_app/presentation/state_holders/theme_controller.dart';
import 'package:ecommerce_app/presentation/ui/screens/auth/update_profile_screen.dart';
import 'package:ecommerce_app/presentation/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  ReadProfileController readProfileController =
      Get.put(ReadProfileController());
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: 'Your Profile',
          elevation: 1,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.blackColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
              Text(
                readProfileController.readProfileModel.data!.cusName ??
                    'Not Found',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${readProfileController.readProfileModel.data!.cusCity ?? 'Not Found'}, ${readProfileController.readProfileModel.data!.cusCountry ?? 'Not Found'}",
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Theme Mode",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 120,
                    child: Obx(() {
                      int currentThemeModeIndex =
                          themeController.themeModeToIndex(
                              themeController.currentThemeMode.value);
                      return AnimatedToggleSwitch<int>.custom(
                        current: currentThemeModeIndex,
                        values: const [0, 1, 2],
                        spacing: 10,
                        onChanged: (value) {
                          themeController.toggleTheme(value);
                        },
                        customStyleBuilder: (context, local, global) {
                          return ToggleStyle(
                            borderRadius: BorderRadius.circular(25),
                            indicatorBorderRadius: BorderRadius.circular(0),
                            indicatorColor: AppColors.primaryColor,
                            borderColor: AppColors.primaryColor,
                          );
                        },
                        animatedIconBuilder: (context, local, global) {
                          IconData iconData;
                          Color iconColor = (local.value == global.current)
                              ? AppColors.foregroundColor
                              : AppColors.greyColor;
                          switch (local.value) {
                            case 0:
                              iconData = Icons.settings;
                              break;
                            case 1:
                              iconData = Icons.wb_sunny;
                              break;
                            case 2:
                              iconData = Icons.nightlight_round;
                              break;
                            default:
                              iconData = Icons.error;
                          }
                          return Icon(
                            iconData,
                            color: iconColor,
                            size: 24,
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const UpdateProfileScreen());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(
                          Icons.mode_edit_outline_rounded,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () async {
                    await AuthController.clear();
                    await AuthController.getAccessToken();
                    Get.snackbar('Success', 'Logout successful.',
                        backgroundColor: AppColors.greenColor,
                        colorText: AppColors.foregroundColor,
                        borderRadius: 10,
                        snackPosition: SnackPosition.BOTTOM);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      AppColors.alertColor.withOpacity(0.2),
                    ),
                    side: MaterialStatePropertyAll(
                      BorderSide(
                        color: AppColors.alertColor,
                      ),
                    ),
                    shape: const MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                    elevation: const MaterialStatePropertyAll(0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Logout",
                        style: TextStyle(
                          color: AppColors.alertColor,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.exit_to_app,
                        color: AppColors.alertColor,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

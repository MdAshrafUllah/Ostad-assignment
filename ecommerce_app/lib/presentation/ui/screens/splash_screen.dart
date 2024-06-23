import 'package:ecommerce_app/presentation/state_holders/auth/auth_controller.dart';
import 'package:ecommerce_app/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:ecommerce_app/presentation/ui/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToNextScreen();
  }

  Future<void> goToNextScreen() async {
    await AuthController.getAccessToken();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Get.offAll(() => const MainBottomNavScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Center(
            child: AppLogo(),
          ),
          Spacer(),
          CircularProgressIndicator(),
          SizedBox(
            height: 16,
          ),
          Text('Version 1.0.0'),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}

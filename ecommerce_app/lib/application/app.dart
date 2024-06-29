import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_app/application/theme/dark_theme_data.dart';
import 'package:ecommerce_app/application/state_holder_binder.dart';
import 'package:ecommerce_app/application/theme/light_theme_data.dart';
import 'package:ecommerce_app/application/utility/app_colors.dart';
import 'package:ecommerce_app/presentation/controller/theme_controller.dart';
import 'package:ecommerce_app/presentation/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EcommerceApp extends StatefulWidget {
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  const EcommerceApp({super.key});

  @override
  State<EcommerceApp> createState() => _EcommerceAppState();
}

class _EcommerceAppState extends State<EcommerceApp> {
  late final StreamSubscription _connectivityStatusStream;
  final ThemeController themeController = Get.put(ThemeController());

  @override
  void initState() {
    super.initState();
    Get.changeThemeMode(ThemeMode.system);
    themeController.onInit();
    checkInitialInternetConnection();
    checkInternetConnectivityStatus();
  }

  void checkInitialInternetConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    handleConnectivityStates(connectivityResult);
  }

  void checkInternetConnectivityStatus() {
    _connectivityStatusStream =
        Connectivity().onConnectivityChanged.listen((status) {
      handleConnectivityStates(status);
    });
  }

  void handleConnectivityStates(List<ConnectivityResult> status) {
    if (status.contains(ConnectivityResult.mobile) &&
        status.contains(ConnectivityResult.wifi)) {
      Get.defaultDialog(
        title: "No Internet",
        middleText: "Please check your internet connection.",
        barrierDismissible: false,
        titleStyle: TextStyle(
          color: AppColors.alertColor,
        ),
      );
    } else {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: EcommerceApp.globalKey,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      initialBinding: StateHolderBinder(),
      themeMode: themeController.currentThemeMode.value,
      theme: lightThemeDataStyle(),
      darkTheme: darkThemeDataStyle(),
    );
  }

  @override
  void dispose() {
    _connectivityStatusStream.cancel();
    super.dispose();
  }
}

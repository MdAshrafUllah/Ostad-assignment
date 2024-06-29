import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static const String _themeModeKey = 'themeMode';
  var currentThemeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? themeModeIndex = prefs.getInt(_themeModeKey);
    if (themeModeIndex != null) {
      final ThemeMode themeMode = ThemeMode.values[themeModeIndex];
      currentThemeMode.value = themeMode;
      Get.changeThemeMode(themeMode);
    } else {
      // Default theme mode is system if no preference is stored
      currentThemeMode.value = ThemeMode.system;
      Get.changeThemeMode(ThemeMode.system);
    }
  }

  void toggleTheme(int index) async {
    ThemeMode newThemeMode = _indexToThemeMode(index);
    currentThemeMode.value = newThemeMode;
    Get.changeThemeMode(newThemeMode);
    await _setThemeMode(newThemeMode);
  }

  Future<void> _setThemeMode(ThemeMode themeMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, themeMode.index);
  }

  int themeModeToIndex(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return 0;
      case ThemeMode.light:
        return 1;
      case ThemeMode.dark:
        return 2;
      default:
        return 0;
    }
  }

  ThemeMode _indexToThemeMode(int index) {
    switch (index) {
      case 0:
        return ThemeMode.system;
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}

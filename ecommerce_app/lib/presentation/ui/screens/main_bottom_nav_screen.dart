import 'package:ecommerce_app/application/utility/app_colors.dart';
import 'package:ecommerce_app/presentation/controller/category_controller.dart';
import 'package:ecommerce_app/presentation/controller/home_slider_controller.dart';
import 'package:ecommerce_app/presentation/controller/main_bottom_nav_screen_controller.dart';
import 'package:ecommerce_app/presentation/controller/new_product_controller.dart';
import 'package:ecommerce_app/presentation/controller/popular_product_controller.dart';
import 'package:ecommerce_app/presentation/controller/special_product_controller.dart';
import 'package:ecommerce_app/presentation/ui/screens/cart_screen.dart';
import 'package:ecommerce_app/presentation/ui/screens/category_list_screen.dart';
import 'package:ecommerce_app/presentation/ui/screens/home_screen.dart';
import 'package:ecommerce_app/presentation/ui/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  final List<Widget> _screens = const [
    HomeScreen(),
    CategoryListScreen(),
    CartScreen(),
    WishListScreen(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<HomeSlidersController>().getHomeSliders();
      Get.find<CategoryController>().getCategories();
      Get.find<PopularProductController>().getPopularProducts();
      Get.find<SpecialProductController>().getSpecialProducts();
      Get.find<NewProductController>().getNewProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavScreenController>(
        builder: (mainBottomNavScreenController) {
      return Scaffold(
        body: _screens[mainBottomNavScreenController.currentSelectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: mainBottomNavScreenController.currentSelectedIndex,
          onTap: mainBottomNavScreenController.changeScreen,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.greyColor,
          showUnselectedLabels: true,
          elevation: 4,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_rounded,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.window_rounded,
                ),
                label: 'Categories'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_basket_rounded,
                ),
                label: 'Cart'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.card_giftcard_rounded,
                ),
                label: 'Wishlist'),
          ],
        ),
      );
    });
  }
}

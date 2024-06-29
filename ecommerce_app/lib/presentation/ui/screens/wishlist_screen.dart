import 'package:ecommerce_app/presentation/controller/main_bottom_nav_screen_controller.dart';
import 'package:ecommerce_app/presentation/controller/wishlist_screen_controller.dart';
import 'package:ecommerce_app/presentation/ui/screens/product_details_screen.dart';
import 'package:ecommerce_app/presentation/ui/widgets/custom_app_bar.dart';
import 'package:ecommerce_app/presentation/ui/widgets/wishlist_product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Get.find<WishListScreenController>().getWishlistProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        Get.find<MainBottomNavScreenController>().backToHome();
      },
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            title: 'WishList',
            elevation: 1,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<WishListScreenController>(
              builder: (wishListScreenController) {
            if (wishListScreenController.getWishListProductsInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (wishListScreenController.wishListProductModel.data != null &&
                wishListScreenController.wishListProductModel.data!.isEmpty) {
              return const Center(
                child: Text('WishList is empty!'),
              );
            }
            return GridView.builder(
              itemCount:
                  wishListScreenController.wishListProductModel.data?.length ??
                      0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => ProductDetailsScreen(
                          productId: wishListScreenController
                              .wishListProductModel.data![index].productId!,
                        ));
                  },
                  child: WishListProductCard(
                    productData: wishListScreenController
                        .wishListProductModel.data![index],
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}

import 'package:ecommerce_app/application/utility/app_colors.dart';
import 'package:ecommerce_app/presentation/controller/cart_screen_con'
    'troller.dart';
import 'package:ecommerce_app/presentation/controller/main_bottom_nav_screen_controller.dart';
import 'package:ecommerce_app/presentation/ui/screens/product_details_screen.dart';
import 'package:ecommerce_app/presentation/ui/widgets/cart_product_card.dart';
import 'package:ecommerce_app/presentation/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Get.find<CartScreenController>().getCartProducts();
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
            title: 'Cart',
            elevation: 1,
          ),
        ),
        body: GetBuilder<CartScreenController>(builder: (cartScreenController) {
          if (cartScreenController.getCartProductsInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (cartScreenController.cartListModel.data != null &&
              cartScreenController.cartListModel.data!.isEmpty) {
            return const Center(
              child: Text('Cart is empty!'),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        cartScreenController.cartListModel.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => ProductDetailsScreen(
                              productId: cartScreenController
                                  .cartListModel.data![index].productId!));
                        },
                        child: CartProductCard(
                          cartListData:
                              cartScreenController.cartListModel.data![index],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Price',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            '\$${cartScreenController.totalPrice}',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Checkout'),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

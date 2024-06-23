import 'package:ecommerce_app/application/utility/app_colors.dart';
import 'package:ecommerce_app/data/models/cart_list_model.dart';
import 'package:ecommerce_app/presentation/state_holders/cart_screen_controller.dart';
import 'package:ecommerce_app/presentation/state_holders/delete_cart_list_product_controller.dart';
import 'package:ecommerce_app/presentation/ui/widgets/product_details/custom_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartProductCard extends StatelessWidget {
  final CartListData cartListData;

  const CartProductCard({
    super.key,
    required this.cartListData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: AppColors.greyColor.withOpacity(0.5),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(cartListData.product?.image ?? ''),
                fit: BoxFit.cover,
              )),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartListData.product?.title ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Color: ${cartListData.color} ',
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'Size: ${cartListData.size}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                          onTap: () async {
                            await deleteCartProduct(cartListData.productId!);
                          },
                          child: Icon(
                            Icons.delete_rounded,
                            color: AppColors.alertColor,
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${cartListData.product?.price ?? 0}',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        width: 85,
                        child: FittedBox(
                          child: CustomStepper(
                            lowerLimit: 1,
                            upperLimit: 20,
                            stepValue: 1,
                            value: int.parse(cartListData.qty!),
                            onChange: (int value) {
                              Get.find<CartScreenController>()
                                  .changeItem(cartListData.productId!, value);
                            },
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> deleteCartProduct(int productId) async {
    final response = await Get.find<DeleteCartListProductController>()
        .deleteCartProduct(productId);
    if (response) {
      Get.snackbar('Success', 'Product delete successful.',
          backgroundColor: AppColors.greenColor,
          colorText: AppColors.foregroundColor,
          borderRadius: 10,
          snackPosition: SnackPosition.BOTTOM);
      Get.find<CartScreenController>().getCartProducts();
    } else {
      Get.snackbar('Failed', 'Product delete failed! Try again',
          backgroundColor: AppColors.alertColor,
          colorText: AppColors.foregroundColor,
          borderRadius: 10,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}

import 'package:ecommerce_app/application/utility/app_colors.dart';
import 'package:ecommerce_app/data/models/wishlist_product_model.dart';
import 'package:ecommerce_app/presentation/state_holders/delete_wishlist_product_controller.dart';
import 'package:ecommerce_app/presentation/state_holders/wishlist_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListProductCard extends StatelessWidget {
  final WishListProductData productData;

  const WishListProductCard({
    super.key,
    required this.productData,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Card(
      shadowColor: AppColors.primaryColor.withOpacity(0.3),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        width: 130,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                height: size.height / 12,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(productData.product?.image ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Text(
                    productData.product?.title ?? '',
                    maxLines: 1,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.cardTextColor,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${productData.product?.price ?? 0}',
                        style: TextStyle(
                            fontSize: 13,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            size: 15,
                            color: AppColors.startColor,
                          ),
                          Text(
                            '${productData.product?.star ?? 0}',
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.cardTextColor,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          await deleteWishlistProduct(productData.productId!);
                        },
                        child: Icon(
                          Icons.delete_forever_outlined,
                          color: AppColors.alertColor,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteWishlistProduct(int productId) async {
    final response = await Get.find<DeleteWishListProductController>()
        .deleteWishlistProduct(productId);
    if (response) {
      Get.snackbar('Success', 'Remove from wishlist successful.',
          backgroundColor: AppColors.greenColor,
          colorText: AppColors.foregroundColor,
          borderRadius: 10,
          snackPosition: SnackPosition.BOTTOM);
      await Get.find<WishListScreenController>().getWishlistProducts();
    } else {
      Get.snackbar('Failed', 'Remove from wishlist failed!',
          backgroundColor: AppColors.alertColor,
          colorText: AppColors.foregroundColor,
          borderRadius: 10,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}

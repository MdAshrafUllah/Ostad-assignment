import 'package:ecommerce_app/application/utility/app_colors.dart';
import 'package:ecommerce_app/data/models/product_model.dart';
import 'package:ecommerce_app/presentation/controller/create_wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  final ProductData productData;

  const ProductCard({
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
                height: size.height / 8.5,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(productData.image ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    productData.title ?? '',
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
                        '\$${productData.price ?? 0}',
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
                            '${productData.star ?? 0}',
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.cardTextColor,
                            ),
                          ),
                        ],
                      ),
                      GetBuilder<CreateWishListController>(
                          builder: (createWishListController) {
                        return Container(
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: InkWell(
                              onTap: () async {
                                await setThisProductInWishlist(
                                    createWishListController);
                              },
                              child: Icon(
                                Icons.favorite_border,
                                size: 12,
                                color: AppColors.foregroundColor,
                              ),
                            ),
                          ),
                        );
                      })
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

  Future<void> setThisProductInWishlist(
      CreateWishListController createWishListController) async {
    final response =
        await createWishListController.setProductInWishList(productData.id!);
    if (response) {
      Get.snackbar('Success', 'Add wishlist successfully.',
          backgroundColor: AppColors.greenColor,
          colorText: AppColors.foregroundColor,
          borderRadius: 10,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Failed', 'Add wishlist failed! Try again',
          backgroundColor: AppColors.alertColor,
          colorText: AppColors.foregroundColor,
          borderRadius: 10,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}

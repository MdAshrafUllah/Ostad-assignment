import 'package:ecommerce_app/application/utility/app_colors.dart';
import 'package:ecommerce_app/data/models/product_details_model.dart';
import 'package:ecommerce_app/presentation/controller/create_wishlist_controller.dart';
import 'package:ecommerce_app/presentation/ui/screens/product_review_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductRatingReviewWishList extends StatelessWidget {
  final ProductDetailsData productDetailsData;

  const ProductRatingReviewWishList(
      {super.key, required this.productDetailsData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(
              Icons.star,
              size: 18,
              color: AppColors.startColor,
            ),
            Text(
              '${productDetailsData.product?.star ?? 0}',
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.cardTextColor),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            Get.to(() => ProductReviewScreen(
                  productId: productDetailsData.productId!,
                ));
          },
          child: Text(
            'Reviews',
            style: TextStyle(
                fontSize: 15,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500),
          ),
        ),
        GetBuilder<CreateWishListController>(
            builder: (createWishListController) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: InkWell(
                onTap: () async {
                  await setThisProductInWishlist(createWishListController);
                },
                child: Icon(
                  Icons.favorite_border,
                  size: 16,
                  color: AppColors.foregroundColor,
                ),
              ),
            ),
          );
        })
      ],
    );
  }

  Future<void> setThisProductInWishlist(
      CreateWishListController createWishListController) async {
    final response = await createWishListController
        .setProductInWishList(productDetailsData.productId!);
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

import 'package:ecommerce_app/presentation/controller/add_to_cart_controller.dart';
import 'package:ecommerce_app/presentation/controller/auth/create_profile_screen_controller.dart';
import 'package:ecommerce_app/presentation/controller/auth/email_verification_screen_controller.dart';
import 'package:ecommerce_app/presentation/controller/auth/otp_verification_screen_controller.dart';
import 'package:ecommerce_app/presentation/controller/auth/read_profile_controller.dart';
import 'package:ecommerce_app/presentation/controller/cart_screen_controller.dart';
import 'package:ecommerce_app/presentation/controller/category_controller.dart';
import 'package:ecommerce_app/presentation/controller/category_product_list_controller.dart';
import 'package:ecommerce_app/presentation/controller/create_review_screen_controller.dart';
import 'package:ecommerce_app/presentation/controller/create_wishlist_controller.dart';
import 'package:ecommerce_app/presentation/controller/delete_cart_list_product_controller.dart';
import 'package:ecommerce_app/presentation/controller/delete_wishlist_product_controller.dart';
import 'package:ecommerce_app/presentation/controller/home_slider_controller.dart';
import 'package:ecommerce_app/presentation/controller/main_bottom_nav_screen_controller.dart';
import 'package:ecommerce_app/presentation/controller/new_product_controller.dart';
import 'package:ecommerce_app/presentation/controller/popular_product_controller.dart';
import 'package:ecommerce_app/presentation/controller/product_details_screen_controller.dart';
import 'package:ecommerce_app/presentation/controller/product_review_screen_controller.dart';
import 'package:ecommerce_app/presentation/controller/special_product_controller.dart';
import 'package:ecommerce_app/presentation/controller/wishlist_screen_controller.dart';
import 'package:get/get.dart';

class StateHolderBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(OtpVerificationScreenController());
    Get.put(MainBottomNavScreenController());
    Get.put(EmailVerificationScreenController());
    Get.put(HomeSlidersController());
    Get.put(CategoryController());
    Get.put(PopularProductController());
    Get.put(SpecialProductController());
    Get.put(NewProductController());
    Get.put(ProductDetailsScreenController());
    Get.put(AddToCartController());
    Get.put(CategoryProductListController());
    Get.put(CartScreenController());
    Get.put(CreateProfileScreenController());
    Get.put(ReadProfileController());
    Get.put(DeleteCartListProductController());
    Get.put(DeleteWishListProductController());
    Get.put(WishListScreenController());
    Get.put(CreateWishListController());
    Get.put(ProductReviewScreenController());
    Get.put(CreateReviewScreenController());
  }
}

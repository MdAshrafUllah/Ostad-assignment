import 'package:ecommerce_app/presentation/state_holders/category_controller.dart';
import 'package:ecommerce_app/presentation/state_holders/main_bottom_nav_screen_controller.dart';
import 'package:ecommerce_app/presentation/ui/screens/category_product_list_screen.dart';
import 'package:ecommerce_app/presentation/ui/widgets/category_card.dart';
import 'package:ecommerce_app/presentation/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Get.find<MainBottomNavScreenController>().backToHome();
      },
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            title: 'Categories',
            elevation: 1,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Get.find<CategoryController>().getCategories();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child:
                GetBuilder<CategoryController>(builder: (categoryController) {
              if (categoryController.getCategoriesInProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return GridView.builder(
                itemCount: categoryController.categoryModel.data?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => CategoryProductListScreen(
                          categoryId: index + 1,
                          remarkName: categoryController
                                  .categoryModel.data![index].categoryName ??
                              ''));
                    },
                    child: FittedBox(
                      child: CategoryCard(
                        categoryData:
                            categoryController.categoryModel.data![index],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}

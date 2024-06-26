import 'package:ecommerce_app/data/models/product_model.dart';
import 'package:ecommerce_app/presentation/ui/screens/product_details_screen.dart';
import 'package:ecommerce_app/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListView extends StatelessWidget {
  final List<ProductData> productData;

  const ProductListView({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 165,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productData.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => ProductDetailsScreen(
                    productId: productData[index].id!,
                  ));
            },
            child: ProductCard(
              productData: productData[index],
            ),
          );
        },
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/application/utility/app_colors.dart';
import 'package:flutter/material.dart';

class ProductImageSlider extends StatelessWidget {
  final List<String> imageList;

  ProductImageSlider({super.key, required this.imageList});

  final ValueNotifier<int> _selectedSlider = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 300.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              viewportFraction: 1,
              onPageChanged: (int page, _) {
                _selectedSlider.value = page;
              }),
          items: imageList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.greyColor.withOpacity(0.4),
                    ),
                    alignment: Alignment.center,
                    child: Image.network(
                      i,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ));
              },
            );
          }).toList(),
        ),
        Positioned(
          bottom: 15,
          left: 0,
          right: 0,
          child: ValueListenableBuilder(
            valueListenable: _selectedSlider,
            builder: (context, value, _) {
              List<Widget> dottedList = [];
              for (int i = 0; i < imageList.length; i++) {
                dottedList.add(Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: value == i
                            ? AppColors.primaryColor
                            : AppColors.greyColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: value == i
                          ? AppColors.primaryColor
                          : AppColors.transparentColor),
                ));
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: dottedList,
              );
            },
          ),
        )
      ],
    );
  }
}

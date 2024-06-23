import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/application/utility/app_colors.dart';
import 'package:ecommerce_app/data/models/slider_model.dart';
import 'package:flutter/material.dart';

class HomeSlider extends StatelessWidget {
  HomeSlider({super.key, required this.sliders});

  final List<SliderData> sliders;

  final ValueNotifier<int> _selectedSlider = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: size.width / 2.2,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              enlargeFactor: 0.2,
              viewportFraction: 1,
              onPageChanged: (int page, _) {
                _selectedSlider.value = page;
              }),
          items: sliders.map((sliderData) {
            return Builder(
              builder: (BuildContext context) {
                return Stack(
                  children: [
                    Container(
                      height: size.width,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        sliderData.image ?? '',
                        fit: BoxFit.cover,
                        height: size.width,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width / 2,
                            child: Text(
                              "${sliderData.title ?? ''} ${sliderData.price ?? ''}",
                              style: TextStyle(
                                  color: AppColors.blackColor.withOpacity(0.8),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: size.width / 4,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                backgroundColor: AppColors.primaryColor,
                                foregroundColor: AppColors.foregroundColor,
                              ),
                              child: const Text(
                                'Buy Now',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(
          height: 8,
        ),
        ValueListenableBuilder(
          valueListenable: _selectedSlider,
          builder: (context, value, _) {
            List<Widget> dottedList = [];
            for (int i = 0; i < sliders.length; i++) {
              dottedList.add(Container(
                width: 12,
                height: 12,
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
                      : AppColors.transparentColor,
                ),
              ));
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: dottedList,
            );
          },
        )
      ],
    );
  }
}

import 'package:ecommerce_app/application/utility/app_colors.dart';
import 'package:ecommerce_app/data/utility/product_details_color.dart';
import 'package:ecommerce_app/presentation/ui/widgets/section_title.dart';
import 'package:flutter/material.dart';

class ProductColorPicker extends StatefulWidget {
  const ProductColorPicker(
      {super.key,
      required this.colors,
      required this.onSelected,
      required this.initialSelected});

  final List<String> colors;
  final Function(int selectIndex) onSelected;
  final int initialSelected;

  @override
  State<ProductColorPicker> createState() => _ProductColorPickerState();
}

class _ProductColorPickerState extends State<ProductColorPicker> {
  int _selectedColorIndex = 0;

  @override
  void initState() {
    _selectedColorIndex = widget.initialSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle(title: 'Color'),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 28,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.colors.length,
            itemBuilder: (context, index) {
              String colorName = widget.colors[index];
              return InkWell(
                onTap: () {
                  _selectedColorIndex = index;
                  widget.onSelected(index);
                  if (mounted) {
                    setState(() {});
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.greyColor),
                    shape: BoxShape.circle,
                    color: colorMap[colorName],
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    _selectedColorIndex == index ? Icons.check : null,
                    color: colorName == "White"
                        ? AppColors.blackColor
                        : colorName == "Black"
                            ? AppColors.foregroundColor
                            : AppColors.blackColor,
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: 5,
              );
            },
          ),
        ),
      ],
    );
  }
}

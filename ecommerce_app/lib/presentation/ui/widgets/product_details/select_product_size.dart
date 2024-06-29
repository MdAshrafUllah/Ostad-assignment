import 'package:ecommerce_app/application/utility/app_colors.dart';
import 'package:ecommerce_app/presentation/ui/widgets/section_title.dart';
import 'package:flutter/material.dart';

class ProductSizePicker extends StatefulWidget {
  const ProductSizePicker(
      {super.key,
      required this.sizes,
      required this.onSelected,
      required this.initialSelected});

  final List<String> sizes;
  final Function(int selectIndex) onSelected;
  final int initialSelected;

  @override
  State<ProductSizePicker> createState() => _ProductSizePickerState();
}

class _ProductSizePickerState extends State<ProductSizePicker> {
  int _selectedSizeIndex = 0;

  @override
  void initState() {
    _selectedSizeIndex = widget.initialSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle(title: 'Size'),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 28,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.sizes.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  _selectedSizeIndex = index;
                  widget.onSelected(index);
                  if (mounted) {
                    setState(() {});
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: _selectedSizeIndex == index
                              ? AppColors.primaryColor
                              : AppColors.greyColor),
                      shape: BoxShape.circle,
                      color: _selectedSizeIndex == index
                          ? AppColors.primaryColor
                          : null),
                  alignment: Alignment.center,
                  child: Text(
                    widget.sizes[index],
                    style: TextStyle(
                      color: _selectedSizeIndex == index
                          ? AppColors.foregroundColor
                          : null,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: 8,
              );
            },
          ),
        ),
      ],
    );
  }
}

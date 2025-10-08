import 'package:fedman_admin_app/core/common_widgets/rounded_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_colors.dart';


class OptionSelector extends StatefulWidget {
  final List<String> options;
  final ValueChanged<int> onOptionSelected;
  final int selectedIndex;
  final double optionRadius;
  final double height;
  final Color? bgColor;

  const OptionSelector({super.key,
    required this.options,
    required this.onOptionSelected,this.bgColor,
    this.selectedIndex = 0, this.optionRadius = 20, this.height = 60});

  @override
  OptionSelectorState createState() => OptionSelectorState();
}

class OptionSelectorState extends State<OptionSelector> {
  int selectedIndex = 0;

  @override
  void initState() {
    selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final bool isDarkMode = Theme
        .of(context)
        .brightness == Brightness.dark;
    return RoundedContainerWidget(
      height: widget.height,
      showShadow: false,
      showBorder: false,
      borderRadius: 5,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.options.length, (index) {
            final isSelected = selectedIndex == index;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  widget.onOptionSelected(selectedIndex);
                },
                child: AnimatedContainer(
                  alignment: Alignment.center,
                  height: widget.height,
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 5),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.baseWhiteColor,
                    borderRadius: BorderRadius.circular(widget.optionRadius),
                  ),
                  child: Text(
                    widget.options[index],
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.baseWhiteColor
                          : AppColors.neutral600,

                      fontWeight: isSelected ? FontWeight.bold : FontWeight
                          .normal,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

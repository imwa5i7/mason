import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/presentation/components/buttons/wrapper_button.dart';
import 'package:{{project_name.snakeCase()}}/presentation/resources/resources.dart';

class ChipButton extends StatelessWidget {
  final bool isSelected;
  final Function() onPressed;
  final String label;
  final double verticalPadding;
  final double horizontalPadding;
  final double? height;
  final Color? selectedColor;

  const ChipButton(
      {super.key,
      this.isSelected = false,
      required this.onPressed,
      required this.label,
      this.verticalPadding = Sizes.s8,
      this.horizontalPadding = Sizes.s16,
      this.height,
      this.selectedColor});

  @override
  Widget build(BuildContext context) {
    return WrapperButton(
      onTap: onPressed,
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? selectedColor ?? Palette.primary : Palette.white,
          borderRadius: BorderRadius.circular(Sizes.s30),
        ),
        child: Text(
          label,
          style: context.bodyMedium
              .copyWith(color: isSelected ? Palette.white : Palette.black),
        ),
      ),
    );
  }
}
